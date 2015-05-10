#!/bin/bash

FREE=`free -m | grep Mem | awk '{ print $4 }'`
TOTAL=`free -m | grep Mem | awk '{ print $2 }'`
PERC=$((FREE*100/TOTAL))
PERCBAR=`echo -e "$PERC" | gdbar -bg '#454545' -fg '#cd546c' -h 1 -w 50 | sed "s/\ .*\%//g"`

echo "$PERCBAR"
