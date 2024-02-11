#!/bin/bash

pushd $(dirname $0) > /dev/null
echo "usb0,wlan0->"
bash ../bin/ip_addr.sh usb0
bash ../bin/ip_addr.sh wlan0
bash ../bin/ssid.sh
pushd > /dev/null
