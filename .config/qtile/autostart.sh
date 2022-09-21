#! /bin/bash
xbindkeys &
python3 "$SCRIPTS/change_desktop_wallpaper.py" &
picom &
copyq &
flameshot &
#rclone mount points to google drive
rclone mount --daemon --dir-cache-time 30m --vfs-cache-mode full gd:"PROYECTO IDEA" "$HOME/Documents/IDEA-REMOTE"
rclone mount --daemon --dir-cache-time 30m --vfs-cache-mode full gd:"PERSONAL-WORK" "$HOME/Documents/PERSONAL-WORK-REMOTE"
rclone mount --daemon --dir-cache-time 30m --vfs-cache-mode full gd:"DATOS CASA (PINAR)" "$HOME/Documents/HOME-DATA-REMOTE"
rclone mount --daemon --dir-cache-time 30m --vfs-cache-mode full gd:"UNIVERSIDAD NACIONAL" "$HOME/Documents/UNIVERSITY-REMOTE"
rclone mount --daemon --dir-cache-time 30m --vfs-cache-mode full gdd: "$HOME/Documents/PERSONAL-DATA-REMOTE"
rclone mount --daemon --dir-cache-time 30m --vfs-cache-mode full gd:"DEV BOOKS" "$HOME/Documents/BOOKS"
#noisetorch -s alsa_input.usb-Corsair_CORSAIR_VOID_ELITE_Wireless_Gaming_Dongle-00.mono-fallback -i &
#redshift &
