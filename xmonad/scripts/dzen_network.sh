#!/bin/bash
source $(dirname $0)/config.sh

XPOS=$((800 + $XOFFSET))
WIDTH="200"
LINES="6"


essid=$(ifconfig wlp3s0b1 | sed -n "1p" | awk -F '"' '{print $2}')
mode=$(ifconfig wlp3s0b1 | sed -n "1p" | awk -F " " '{print $3}' | cut -c 7-14)
freq=$(ifconfig wlp3s0b1 | sed -n "2p" | awk -F " " '{print $2}' | cut -d":" -f2)
mac=$(ip a show wlp3s0b1 | sed -n "2p" | awk '{ print $2 }')
lvl=$(ifconfig wlp3s0b1 | sed -n "6p" | awk -F " " '{print $4}' | cut -d"=" -f2)
down=$(ip -s -s link ls wlp3s0b1 | sed -n "4p" | awk '{ $1=$1/1024^2; print $1,"MB" }')
up=$(ip -s -s link ls wlp3s0b1 | sed -n "8p" | awk '{ $1=$1/1024^2; print $1,"MB" }')
local=$(ip a show wlp3s0b1 | sed -n "3p" | awk '{ print $2 }')
inet=$(wget http://checkip.dyndns.org/ -O - -o /dev/null | cut -d: -f 2 | cut -d\< -f 1)

(
    echo " ^fg($foreground)Network";
    echo " ^fg($highlight)wlp3s0b1";
    echo " IP:^fg($highlight)$inet ^fg($foreground)Type: ^fg($highlight)wireless";
    echo " Down: ^fg($highlight)$down ^fg($foreground)Up: ^fg($highlight)$up";
    echo " Local: ^fg($highlight)$local";  echo " MAC: ^fg($highlight)$mac";
    echo " ";
    sleep 60
) | dzen2 -fg $foreground -bg $background -fn $font -x $XPOS -y $YPOS -w $WIDTH -l $LINES -e 'onstart=uncollapse;button1=exit;button3=exit'
