#!/bin/bash

pushd $(dirname $0) > /dev/null
ls -1 ../etc | grep -E "^[0-9]+?\.sh" | while read line
do
  bash ../etc/${line} > /var/pi_status/$(echo ${line} | cut -d. -f1)
done

lines=$(cat /var/pi_status/$(cat /var/pi_status/current) | sed -r 's/^(.+?)/\"\1\"/' | tr '\n' ' ' | sed -r 's/ $//g')
bash -c "sudo python3  /usr/local/pi_status/bin/ssd1306.py ${lines[@]}"
pushd > /dev/null
