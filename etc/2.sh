#!/bin/bash

pushd $(dirname $0) > /dev/null
echo "CPU :"$(bash ../bin/cpu_use_rate.sh)
echo "Mem :"$(bash ../bin/resource_use_rate.sh mem)
echo "Swap:"$(bash ../bin/resource_use_rate.sh swap)
echo "Temp:"$(bash ../bin/cpu_degree_celsius.sh)
pushd > /dev/null
