#!/bin/bash

VNC_PID=$(sudo lsof -antP -s TCP:LISTEN -i 4 -i :5900)
if [ -n "${VNC_PID}" ]; then
  echo "VNC OK"
else
  echo "VNC NG"
fi
