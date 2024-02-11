#!/bin/bash

SSH_PID=$(sudo lsof -antP -s TCP:LISTEN -i 4 -i :22)
if [ -n "${SSH_PID}" ]; then
  echo "SSH OK"
else
  echo "SSH NG"
fi
