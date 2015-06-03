#!/bin/bash

percent=`acpi -V | grep "Battery 0:" | head -n 1 | cut -d"," -f 2 | xargs | cut -d"%" -f 1`
percent_bar=`echo -e "$percent" | gdbar -bg '#454545' -fg '#cd546c' -h 1 -w 50 | sed "s/\ .*\%//g"`

echo "$percent_bar"
