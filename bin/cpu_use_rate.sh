#!/bin/bash

echo $(( 100 - $(vmstat | tail -n1 | awk '{print $15}') ))%
