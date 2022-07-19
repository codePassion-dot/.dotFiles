#! /bin/bash
xbindkeys &
python3 "$SCRIPTS/change_desktop_wallpaper.py" &
picom &
copyq &
flameshot &
#noisetorch -s alsa_input.usb-Corsair_CORSAIR_VOID_ELITE_Wireless_Gaming_Dongle-00.mono-fallback -i &
#redshift &
