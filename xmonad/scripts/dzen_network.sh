#!/bin/bash
source $(dirname $0)/config.sh
XPOS=928
WIDTH="210"
LINES="8"

essid=$(ifconfig wlp3s0b1 | sed -n "1p" | awk -F '"' '{print $2}')
mode=$(ifconfig wlp3s0b1 | sed -n "1p" | awk -F " " '{print $3}' | cut -c 7-14)
freq=$(ifconfig wlp3s0b1 | sed -n "2p" | awk -F " " '{print $2}' | cut -d":" -f2)
mac=$(ifconfig wlp3s0b1 | sed -n "1p" | awk -F " " '{print $5}')
lvl=$(ifconfig wlp3s0b1 | sed -n "6p" | awk -F " " '{print $4}' | cut -d"=" -f2)
down=$(ifconfig wlp3s0b1 | sed -n "7p" | awk -F " " '{print $3}' | cut -c 2-15)
up=$(ifconfig wlp3s0b1 | sed -n "7p" | awk -F " " '{print $7}' | cut -c 2-15)
local=$(ifconfig wlp3s0b1 | sed -n "2p" | awk -F " " '{print $2}' | cut -d":" -f2)
inet=$(wget http://checkip.dyndns.org/ -O - -o /dev/null | cut -d: -f 2 | cut -d\< -f 1)
netmask=$(ifconfig wlp3s0b1 | sed -n "2p" | awk -F " " '{print $4}' | cut -c 8-22)
broadcast=$(ifconfig wlp3s0b1 | sed -n "2p" | awk -F " " '{print $3}' | cut -c 7-20)
(echo " ^fg($foreground)Network"; echo " ^fg($highlight)wlp3s0b1"; echo " IP:^fg($highlight)$inet  ^fg($foreground) Type: ^fg($highlight)wireless"; echo " Down: ^fg($highlight)$down MiB  ^fg($foreground) Up: ^fg($highlight)$up MiB";  echo " Netmask: ^fg($highlight)$netmask";  echo " Broadcast: ^fg($highlight)$broadcast"; echo " Local: ^fg($highlight)$local";  echo " MAC: ^fg($highlight)$mac";  echo " "; sleep 60) | dzen2 -fg $foreground -bg $background -fn $font -x $XPOS -y $YPOS -w $WIDTH -l $LINES -e 'onstart=uncollapse,hide;button1=exit;button3=exit'
