# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# export MANPATH="/usr/local/man:$MANPATH"
export PATH="$HOME/.local/bin:/home/jacobo/.config/rofi/bin:$PATH"
export DWM_PATCHES="$HOME/Documents/dwm_patches"
export BACKGROUNDS="$HOME/Pictures"
export SCRIPTS="$HOME/Documents/scripts"
export QTWEBENGINE_CHROMIUM_FLAGS=--widevine-path="/usr/lib/chromium/libwidevinecdm.so"
export KASPERSKYPWLINK=https://my.kaspersky.com/MyPasswords#/all
export WHATSAPPWEBLINK=https://web.whatsapp.com/

#rclone mount points to google drive
rclone mount --daemon --dir-cache-time 48h --vfs-cache-mode full gd:"PROYECTO IDEA" $HOME/Documents/IDEA-REMOTE
rclone mount --daemon --dir-cache-time 48h --vfs-cache-mode full gd:"UNIVERSIDAD NACIONAL" $HOME/Documents/UNIVERSITY-REMOTE
rclone mount --daemon --dir-cache-time 48h --vfs-cache-mode full gdd: $HOME/Documents/PERSONAL-DATA-REMOTE
# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# if running zsh
if [ -n "$ZSH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.zshrc" ]; then
	. "$HOME/.zshrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# set PATH so it includes fnm bin if it exists
if [ -d "$HOME/.fnm" ] ; then
    PATH="$HOME/.fnm:$PATH"
fi
