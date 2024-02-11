#!/bin/bash

connect=$(ping -4vn -c 5 1.1.1.1 2> /dev/null | grep -E "icmp_seq=[0-9]+ ttl=[0-9]+ time=[0-9]+\.[0-9]+ ms" | wc -l)

if [ ${connect} -ge 1 ]; then
  echo "Internet OK"
else
  echo "Internet NG"
fi
