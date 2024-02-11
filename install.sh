#!/bin/bash

PREFIX=/usr/local

functiion usag {
  cat <<EOF
Usage:
    $(basename $0) [<options>]

Options:
    -p PREFIX: インストール対象のディレクトリを指定する、省略時は/usr/local
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

useradd -G sudo pi_status -s /sbin/nologin
mkdir /var/pi_status
chown -R pi_stauts:pi_status +rw /var/pi_status
echo 0 > /var/pi_status/current

ls -1 ./bin | while read line
do
  cp ./bin/${line} ${PREFIX}/bin
  chown pi_status:pi_status ${PREFIX}/bin/${line}
  chmod +rx ${PREFIX}/bin/${line}
done

ls -1 ./etc | while read line
do
  cp ./etc/${line} ${PREFIX}/etc
  chown pi_status:pi_status ${PREFIX}/etc/${line}
  chmod +rw ${PREFIX}/etc/${line}
done

ls -1 ./system | while read line
do
  cp ./system/${line} /usr/lib/systemd/system
done
