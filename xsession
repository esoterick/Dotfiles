#!/bin/sh

#
# ~/.xsession
#
# Executed by xdm/gdm/kdm at login
#

#/bin/bash --login -i ~/.xinitrc
/usr/bin/urxvtd -q -f -o
/usr/bin/zsh --login -i ~/.xinitrc
