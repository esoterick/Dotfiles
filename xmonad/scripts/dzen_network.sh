#!/bin/bash
source $(dirname $0)/config.sh

netctl=$(netctl list | egrep "^* " | awk '{print $2}' )
ip4=$(ip a show wlp3s0b1 | egrep "^\s+inet\s" | awk '{print $2}')
ip6=$(ip a show wlp3s0b1 | egrep "^\s+inet6\s" | awk '{print $2}')

echo " ^fg($foreground)network ^fg(#cd546c)wlp3s0b1 ^fg($foreground)netctl ^fg(#cd546c)$netctl ^fg($foreground)ip4 ^fg(#cd546c)$ip4 ^fg($foreground)ip6 ^fg(#cd546c)$ip6"
