import os
import pathlib
import subprocess
import sys
import time

import RPi.GPIO as GPIO

sys.path.append(os.path.join(os.path.dirname(__file__), '../etc'))
import pi_status_config as config
import ssd1306
import tact_switch


def reads():
    status_file_dir = pathlib.Path(config.STATUS_FILE_DIR)
    with open(status_file_dir.joinpath('current'), mode='r') as f1:
        num = str(int(f1.read()))
        with open(status_file_dir.joinpath(num), mode='r') as f2:
            return f2.readlines()


def update_pi_status_current():
    current_id_file = pathlib.Path(config.STATUS_FILE_DIR).joinpath('current')
    with open(current_id_file, mode='r') as f:
        current = int(f.read())
    with open(current_id_file, mode='w') as f:
        if current + 1 < 3:
            f.write(str(current + 1))
        else:
            f.write('0')


def print_status_on_oled():
    ssd1306.print_oled(reads())
    time.sleep(1)


def start():
    print_status_on_oled()
    on_events = [
        update_pi_status_current,
        print_status_on_oled
    ]
    tact_switch.dispatch(on_events=on_events)


if __name__ == '__main__':
    start()
