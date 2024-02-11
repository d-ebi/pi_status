#!/bin/bash

echo $(echo "scale=1;$(sudo cat /sys/class/thermal/thermal_zone0/temp) / 1000" | bc)'[deg C]'
