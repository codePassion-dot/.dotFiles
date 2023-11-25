#! /bin/bash
feh --bg-scale $HOME/.dotfiles/qtile/.config/qtile/icons/relax-waifu.jpeg $HOME/.dotfiles/qtile/.config/qtile/icons/waifu-vertical.jpeg &
xbindkeys &
redshift &
flameshot &
picom --experimental-backend --transparent-clipping &
copyq &
libinput-gestures-setup start
sh $HOME/.local/bin/create-rclone-mounts
