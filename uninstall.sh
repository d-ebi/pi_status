#!/bin/bash

PREFIX=/usr/local

functiion usag {
  cat <<EOF
Usage:
    $(basename $0) [<options>]

Options:
    -p PREFIX: インストールしたのディレクトリを指定する、省略時は/usr/local
EOF 
}

while getopts "p:" key
do
  case "${key}" in
    p)
      if [ -n ${OPTARG} ]; then
        echo "Directory \"${OPTARG}\" is not found." 1>&2
        exit 1
      fi
      PREFIX=${OPTARG}
      ;;
    *)
      usage
      exit 2
      ;;
  esac
done

if [ $(whoami) != "root" ]; then
  echo "[ERROR] Need root privileges." 1>&2
fi

SYSTEMD_UNITS=/usr/lib/systemd/system

if [ -e ${SYSTEMD_UNITS}/pi_status.service ] || [ -e ${SYSTEMD_UNITS}/update_pi_status.timer ]; then
  echo "pi_status nod installed." 1>&2
  exit 1
fi

systemctl disable --now pi_status.service
systemctl disable --now update_pi_status.timer

ls -1 ./bin | while read line
do
  rm -f ${PREFIX}/${line}
done

ls -1 ./etc | while read line
do
  rm -f ${PREFIX}/${line}
done

ls -1 ./system | while read line
do
  rm -f ${PREFIX}/${line}
done

rm -rf /var/pi_status
userdel -r pi_status