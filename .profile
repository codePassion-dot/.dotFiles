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
export ANDROID_SDK_ROOT=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
export JAVA_HOME=$HOME/.local/bin/android-studio/jre
export FLYCTL_INSTALL="/home/jacobo/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"
export DENO_INSTALL="/home/jacobo/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
export GO_INSTALL="/home/jacobo/go"
export PATH="$GO_INSTALL/bin:$PATH"

#rclone mount points to google drive
rclone mount --daemon --dir-cache-time 30m --vfs-cache-mode full gd:"PROYECTO IDEA" "$HOME/Documents/IDEA-REMOTE"
rclone mount --daemon --dir-cache-time 30m --vfs-cache-mode full gd:"PERSONAL-WORK" "$HOME/Documents/PERSONAL-WORK-REMOTE"
rclone mount --daemon --dir-cache-time 30m --vfs-cache-mode full gd:"DATOS CASA (PINAR)" "$HOME/Documents/HOME-DATA-REMOTE"
rclone mount --daemon --dir-cache-time 30m --vfs-cache-mode full gd:"UNIVERSIDAD NACIONAL" "$HOME/Documents/UNIVERSITY-REMOTE"
rclone mount --daemon --dir-cache-time 30m --vfs-cache-mode full gdd: "$HOME/Documents/PERSONAL-DATA-REMOTE"
rclone mount --daemon --dir-cache-time 30m --vfs-cache-mode full gd:"DEV BOOKS" "$HOME/Documents/BOOKS"
# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
	export EDITOR='vim'
else
	export EDITOR='nvim'
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

# set PATH so it includes yarn global bin folder if it exists
if [ -d "$HOME/.yarn/bin" ]; then
	PATH="$HOME/.yarn/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
	PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
	PATH="$HOME/.local/bin:$PATH"
fi
. "$HOME/.cargo/env"
