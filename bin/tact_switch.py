import os
import sys
import time
import RPi.GPIO as GPIO

sys.path.append(os.path.join(os.path.dirname(__file__), '../etc'))
import pi_status_config as config


def setup_gpio():
    GPIO.setmode(GPIO.BCM)
    GPIO.setup(config.TACT_SWITCH_PORT, GPIO.IN, pull_up_down=GPIO.PUD_UP)


def dispatch(on_events=list(), off_events=list()):
    setup_gpio()
    try:
        current_status = 0
        while True:
            switch_status = GPIO.input(config.TACT_SWITCH_PORT)
            is_push = (switch_status == 1)
            is_hold_down = (current_status == 1 and is_push)
            if switch_status == 0:
                current_status = 0
                [e() for e in off_events]
            elif not is_hold_down:
                current_status = 1
                [e() for e in on_events]
            time.sleep(0.1)
    except KeyboardInterrupt:
        GPIO.cleanup()
