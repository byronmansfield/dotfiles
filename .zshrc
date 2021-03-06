# oh-my-zsh settings
export ZSH=${HOME}/.oh-my-zsh
ZSH_THEME="byron"

# language settings
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# set display for x forwarding
export DISPLAY=:0.0

# term
export TERM="xterm-256color-italic"

# Some flags to help with compilation from source
export CPPFLAGS="-I/usr/local/opt/openssl/include"
export LDFLAGS="-L/usr/local/opt/openssl/lib"
export USE_SYSTEM_LIBCLANG=ON
export PKG_CONFIG_PATH="/usr/X11/lib/pkgconfig"
export MANPATH="/usr/local/man:/usr/share/man:${MANPATH}"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set vim as default editor
export VISUAL=vim
export EDITOR=${VISUAL}

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git docker pass)

source $ZSH/oh-my-zsh.sh

# ================================================================
# USER CONFIGURATIONS
# ================================================================

export CODESPACE=${HOME}/code
export DOCKERFILES=${CODESPACE}/dockerfiles
export CHROME_BIN="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"

# ssh
export SSH_KEY_PATH="~/.ssh/id_rsa"

# ================================================================
# SET USER HOME BIN
# ================================================================
if [ -d "$HOME/bin" ]; then
  export PATH="$HOME/bin:$PATH"
fi

# netrunner
export PATH="$PATH:/User/bmansfield/bin/netrunner"

# ================================================================
# GO
# ================================================================
export GOROOT=/usr/local/go
export PATH="$PATH:$GOROOT/bin"
export GOPATH=$HOME/gocode
export GOOS="darwin"
export GOARCH="amd64"

# ================================================================
# PIP
# ================================================================

# auto complete for pip
# function is in .functions
compctl -K _pip_completion pip

# ================================================================
# RVM
# ================================================================
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# ================================================================
# NODEJS
# ================================================================
if test -n "$(command -v npm)"; then
  export NODE_PATH="/usr/local/lib/node_modules:$HOME/node_modules";
  export NPM_PACKAGES="/usr/local/share/npm";
  PATH="$PATH:/usr/local/lib/node_modules/npm/bin:$HOME/node_modules/.bin";
  PATH="$PATH:$NPM_PACKAGES/bin"
fi

# ================================================================
# LOAD LOCAL ENV
# ================================================================
[ -f "${HOME}"/.env ] && source ${HOME}/.env

# ================================================================
# LOAD WORK ENV
# ================================================================
[ -f "${HOME}"/.work ] && source ${HOME}/.work

# ================================================================
# AWS
# ================================================================

# add aws cli to path
export PATH="$PATH:$HOME/Library/Python/2.7/bin"

# source aws env file
[[ -f ~/.aws/env ]] && source ~/.aws/env

# ================================================================
# Google Cloud
# ================================================================

# Add Google Cloud SDK to PATH
if [ -f '/usr/local/bin/path.zsh.inc' ]; then
  source '/usr/local/bin/path.zsh.inc';
fi

# Enables shell command completion for gcloud
if [ -f '/usr/local/bin/completion.zsh.inc' ]; then
  source '/usr/local/bin/completion.zsh.inc';
fi

# ================================================================
# ImageMagick
# ================================================================
export MAGICK_HOME="$HOME/bin/ImageMagick-7.0.5"

# ================================================================
# PATH
# ================================================================

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$GOPATH/bin:$PATH"
export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
export PATH="/Applications/CMake.app/Contents/bin:$PATH"
export PATH="$MAGICK_HOME/bin:$PATH"
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
# export DYLD_LIBRARY_PATH="$MAGICK_HOME/lib/"

# ================================================================
# ALIASES
# ================================================================
[[ -f ~/.aliases ]] && source ~/.aliases

# ================================================================
# FUNCTIONS
# ================================================================
[[ -f ~/.functions ]] && source ~/.functions

# ================================================================
# funtoo.org keychain / GnuPG
# ================================================================

eval $(keychain --nogui --eval --agents ssh --inherit any id_rsa id_rsa_pp)
export GPGKEY="217FD2E8"
export GPG_AGENT_INFO
export GPG_TTY=$(tty)

# Load archey (if installed)
# [[ `type archey 2> /dev/null` && $UID != 0 ]] && archey



