#!/bin/bash

interface=$1

if [ -z ${interface} ]; then
  echo "Usage: ./$0 interface"
  exit 1
fi

if [[ $(ip a s ${interface} | head -n 1) =~ "state UP" ]]; then
  ip a s ${interface} | grep -E "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" | grep -oE "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" | head -n 1
else
  echo "down"
fi
