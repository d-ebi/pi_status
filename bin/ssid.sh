#!/bin/bash

sudo wpa_cli -i wlan0 status | grep -E "^ssid" | cut -d= -f2
