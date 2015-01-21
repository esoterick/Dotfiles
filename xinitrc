#!/bin/sh

feh --bg-scale /home/thor/Photos/lambda.png &

/usr/bin/VBoxClient-all

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

xset +fp ~/.fonts
xset +fp /usr/share/fonts
xset fp rehash

xsetroot -cursor_name left_ptr &

/usr/bin/urxvtd -q -f -o &

exec xmonad
