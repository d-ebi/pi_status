import os
import sys

import adafruit_ssd1306
import board
from PIL import Image, ImageDraw, ImageFont

sys.path.append(os.path.join(os.path.dirname(__file__), '../etc'))
import pi_status_config as config


def create_oled():
    i2c = board.I2C()
    oled = adafruit_ssd1306.SSD1306_I2C(
        config.SSD1306_WIDTH,
        config.SSD1306_HEIGHT,
        i2c,
        addr=config.SSD1306_I2C_ADDRESS
    )
    oled.fill(0)
    oled.show()
    return oled


def load_font():
    return ImageFont.truetype(config.SSD1306_TTF, config.SSD1306_FONT_SIZE)


def add_text(draw, font, text, line = 0):
    draw.text((0, line * config.SSD1306_FONT_SIZE), text, font=font, fill=255)


def show(oled, image):
    oled.image(image)
    oled.show()


def print_oled(lines):
    oled  = create_oled()
    image = Image.new('1', (oled.width, oled.height))
    draw  = ImageDraw.Draw(image)
    font  = load_font()

    i = 0
    max_row = config.SSD1306_HEIGHT / config.SSD1306_FONT_SIZE
    while((i < max_row) and (i < len(lines))):
        add_text(draw, font, lines[i], line=i)
        i += 1
    show(oled, image)


if __name__ == '__main__':
    if len(sys.argv) < 1:
        print(f'{sys.argv[0]} arg1 [...arg2 [...arg3]]')
        sys.exit(1)
    print_oled(sys.argv[1:])
