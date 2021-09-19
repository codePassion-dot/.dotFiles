#!/bin/bash
setxkbmap -layout latam,gb -option grp:alt_shift_toggle
python3 "$SCRIPTS/change_desktop_wallpaper.py" &
compton --config ~/.config/compton.conf &
xbindkeys &
slstatus &
