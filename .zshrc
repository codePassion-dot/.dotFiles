# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/jacobo/.zplug/repos/robbyrussell/oh-my-zsh"
export GPG_TTY=$(tty)
eval `dircolors /home/jacobo/.dir_colors`
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

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
        zsh-syntax-highlighting
        common-aliases
        debian
        docker-compose
        zsh_reload
        web-search
        copydir
        copyfile
        extract
        colored-man-pages
        colorize
        copybuffer
        emoji-clock
        fancy-ctrl-z
        jsontools
        vundle
        zsh-interactive-cd
        python)

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
if [ -f $ZSH_CUSTOM/.zsh_aliases ]; then
    . $ZSH_CUSTOM/.zsh_aliases;
fi
#functions
cps()
{ python3 -m py_compile "$1"
}
ank()
{
    sudo apt-key add "$1"
}
cpfn()
{
	echo -n "$1" | xclip -selection clipboard
}
ndwmp()
{
        patch -p1 < "$1"
}
lwnn()
{
        nmcli device wifi list
}
cwn()
{
        nmcli connection up "$1"
}
sfip()
{
        apt-file search "$1"
}
ipy()
{
        sudo apt install --yes "$1"
}
gpi()
{
        pidof "$1"
}
kpi()
{
        sudo kill -s SIGINT $(gpi "$1")
}
# alias ohmyzsh="mate ~/.oh-my-zsh"
#source /home/jacobo/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
