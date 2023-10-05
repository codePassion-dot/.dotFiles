#! /bin/bash
feh --bg-scale $HOME/Pictures/relax-waifu.jpg $HOME/Pictures/waifu-vertical.png &
xbindkeys &
flameshot &
picom --experimental-backend --transparent-clipping &
copyq &
libinput-gestures-setup start
sh $HOME/.local/bin/create-rclone-mounts
