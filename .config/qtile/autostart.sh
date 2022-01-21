#! /bin/bash 
xbindkeys &
python3 "$SCRIPTS/change_desktop_wallpaper.py" &
picom --experimental-backends &
copyq &
flameshot &
redshift &
#setxkbmap latam
