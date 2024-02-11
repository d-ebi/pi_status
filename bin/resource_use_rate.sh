#!/bin/bash

case $1 in
  "mem")
    TARGET="Mem:"
    AVAILABLE_COLUMN=7
    ;;
  "swap")
    TARGET="Swap:"
    AVAILABLE_COLUMN=4
    ;;
  *)
    echo "Invalid option, option value is [mem|swap]."
    exit 1
    ;;
esac

FREE=$(free)
TOTAL=$(echo "${FREE}" | grep "${TARGET}" | awk '{print $2}')
AVAILABLE=$(echo "${FREE}" | grep "${TARGET}" | awk -v COLUMN=${AVAILABLE_COLUMN} '{print $COLUMN}')
MEM_USE_RATE=$(echo "scale=2; (${TOTAL}-${AVAILABLE})/${TOTAL}*100" | bc | cut -d. -f1)"%"
echo ${MEM_USE_RATE}
