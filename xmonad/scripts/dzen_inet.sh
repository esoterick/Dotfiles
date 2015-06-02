#!/bin/bash

source $(dirname $0)/config.sh

SLEEP=1
FG='#ccc'
BG='#222'
X=1350
Y=0
WIDTH=200
FN='lime'

while true ; do

    WIRELESS="yes"
    INTERFACE="wlp3s0b1"

    # Here we remember the previous rx/tx counts
    RXB=${RXB:-`cat /sys/class/net/${INTERFACE}/statistics/rx_bytes`}
    TXB=${TXB:-`cat /sys/class/net/${INTERFACE}/statistics/tx_bytes`}

    # get new rx/tx counts
    RXBN=`cat /sys/class/net/${INTERFACE}/statistics/rx_bytes`
    TXBN=`cat /sys/class/net/${INTERFACE}/statistics/tx_bytes`

    # calculate the rates
    # format the values to 4 digit fields
    RXR=$(echo "$RXBN - $RXB" | bc)
    if [ $RXR -gt 1024 ] ; then
        RXR=$(printf "%4d\n" $(echo "$RXR / 1024/${SLEEP}" | bc))
        RXRATE="kB/s"
    else
        RXR=$(printf "%4d\n" $(echo "$RXR / ${SLEEP}" | bc))
        RXRATE="B/s"
    fi

    TXR=$(echo "$TXBN - $TXB" | bc)
    if [ $TXR -gt 1024 ] ; then
        TXR=$(printf "%4d\n" $(echo "$TXR / 1024/${SLEEP}" | bc))
        TXRATE="kB/s"
    else
        TXR=$(printf "%4d\n" $(echo "$TXR / ${SLEEP}" | bc))
        TXRATE="B/s"
    fi

    OWN_IP=$(ip a show wlp3s0b1 | sed -n "3p" | awk '{ print $2 }')
    EXT_IP=$(wget http://checkip.dyndns.org/ -O - -o /dev/null | cut -d: -f 2 | cut -d\< -f 1)

    if [ x"$WIRELESS" = x"yes" ]; then
        SIGNAL=$(iwconfig wlp3s0b1 | \grep Quality | awk -F'=' '{ print $2 }' | awk '{ print $1}')
        SIGNALMETER=`echo $SIGNAL`
        DETAILS=$(/usr/sbin/iwconfig $INTERFACE | awk '
                   /^'$INTERFACE'/ {print gensub(":", ": ", 1, $4)}
      /Mode/ {print "Access Point: " $6}
      /Bit Rate/ {print "Bit Rate: " gensub(".*=(.*)", "\\1 MB/s", 1, $2)}')
    fi

    echo -n "^tw()${INTERFACE}: \
^fg(#989584)${RXR}${RXRATE}^p(3)^i(${ICONPATH}/arr_down.xbm)\
^fg(#989584)${TXR}${TXRATE}^i(${ICONPATH}/arr_up.xbm)^fg() strength $SIGNALMETER
^cs()
lan: $OWN_IP
wan: $EXT_IP
$DETAILS"

    # reset old rates
    RXB=$RXBN; TXB=$TXBN

    sleep $SLEEP
done | dzen2 -bg $background -fg $highlight -ta c -l 5 -x $X -fn "$FN" -h 14 -y $Y -w $WIDTH -e 'entertitle=uncollapse;leavetitle=collapse'
