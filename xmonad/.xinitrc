#!/bin/bash

# rebind the caps lock key as ctrl
# xmodmap -e "remove Lock = Caps_Lock"
# xmodmap -e "keysym Caps_Lock = Control_L"
# xmodmap -e "add Control = Control_L"
setxkbmap br
setxkbmap -option ctrl:nocaps

# Load resources

xrdb -merge .Xresources

# Set up an icon tray
stalonetray &

# Fire up apps

# xscreensaver -no-splash &

# dropbox &

# Start udiskie to handle media
udiskie &

# xfce4-power-manager
feh --bg-scale /usr/share/background/xfce/xfce-blue.jpg &

if [ -x /usr/bin/nm-applet ] ; then
   nm-applet --sm-disable &
fi

exec xmonad
