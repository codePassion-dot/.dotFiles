#! /bin/bash 
xbindkeys &
python3 "$SCRIPTS/change_desktop_wallpaper.py" &
picom &
#setxkbmap latam
