#!/usr/bin/bash
TMPFILE="/tmp/updateslist"

po=$(yaourt -Qu --aur 2> "/dev/null" | tee "/tmp/updateslist" | wc -l)

if [ "$po" -gt 1 ]; then
    out=`echo -e "$po updates"`
elif [ "$po" -eq 1 ]; then
    out=`echo -e "1 update"`
else
    out=`echo -e "no updates"`
fi

echo "$out"
