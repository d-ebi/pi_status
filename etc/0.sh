#!/bin/bash

pushd $(dirname $0) > /dev/null
bash ../bin/ssh_status.sh
bash ../bin/vnc_status.sh
bash ../bin/internet_connectivity.sh
pushd > /dev/null
