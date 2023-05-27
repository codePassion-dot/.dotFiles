# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/jacobo/.oh-my-zsh"
export GPG_TTY=$(tty)
eval `dircolors /home/jacobo/.dir_colors`
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="gozilla"
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )
# Vi style:
zle -N vi-easy-motion
bindkey -M vicmd ' ' vi-easy-motion

# To choose pygments style (see pygments documentation)
ZSH_COLORIZE_STYLE="paraiso-dark"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"
# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git
        z
        fzf-tab
        zsh-syntax-highlighting
        alias-finder
        npm
        vi-mode
        common-aliases
        gh
        httpie      
        tmux
        composer 
        direnv 
        emoji
        safe-paste
        ubuntu
        history
        ansible 
        docker-compose
        web-search
        copyfile
        extract
        colored-man-pages
        colorize
        fnm 
        copybuffer
        copypath
        emoji-clock
        fancy-ctrl-z
        jsontools
        vundle
        fd 
        zsh-interactive-cd
        command-not-found
        chucknorris
        python
        calc
        yarn
        forgit
        fzf-zsh-plugin)

source $ZSH/oh-my-zsh.sh

# User configuration


# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Personal Aliases
if [ -f $HOME/.zsh_aliases ]; then
    . $HOME/.zsh_aliases;
fi
if [ -f $HOME/.zsh_functions ]; then
    . $HOME/.zsh_functions;
fi

# alias ohmyzsh="mate ~/.oh-my-zsh"
#source /home/jacobo/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#nnn
export NNN_FIFO=/tmp/nnn.fifo
export NNN_PLUG='p:preview-tui;o:fzopen;j:autojump;l:-!git log;f:finder'
export NNN_FCOLORS="0203040a000d0608090b0501"
export NNN_COLORS='4652'
export NNN_ICONLOOKUP=1

#direnv staff (manage gh config dir environment variable)
eval "$(direnv hook zsh)"

# react native custom debugger
export REACT_DEBUGGER="rndebugger-open --open --port 8081"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_PREVIEW_ADVANCED=true
export FZF_PREVIEW_WINDOW='right:50%:nohidden'
LESSOPEN="|~/.lessfilter %s"; export LESSOPEN

# give a preview of commandline arguments when completing `kill`
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
  '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap

# show systemd unit status
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'

# Images (broken)
zstyle ':fzf-tab:complete:*:*' fzf-preview 'less ${(Q)realpath}'

# git
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview \
	'git diff $word | delta'
zstyle ':fzf-tab:complete:git-log:*' fzf-preview \
	'git log --color=always $word'
zstyle ':fzf-tab:complete:git-help:*' fzf-preview \
	'git help $word | bat -plman --color=always'
zstyle ':fzf-tab:complete:git-show:*' fzf-preview \
	'case "$group" in
	"commit tag") git show --color=always $word ;;
	*) git show --color=always $word | delta ;;
	esac'
zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
	'case "$group" in
	"modified file") git diff $word | delta ;;
	"recent commit object name") git show --color=always $word | delta ;;
	*) git log --color=always $word ;;
	esac'

# pyenv stuff
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# haskell stuff
[ -f "/home/jacobo/.ghcup/env" ] && source "/home/jacobo/.ghcup/env" # ghcup-env

# fnm
export PATH="/home/jacobo/.local/share/fnm:$PATH"
eval "`fnm env`"

# pnpm
export PNPM_HOME="/home/jacobo/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# fnm
export PATH="/home/jacobo/.local/share/fnm:$PATH"
eval "`fnm env`"

# kitty bug whit XDG_CONFIG_DIRS
export KITTY_CONFIG_DIRECTORY=/home/jacobo/.config/kitty
