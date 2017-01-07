# oh-my-zsh settings
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="byron"

# language settings
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Set vim as default editor
export VISUAL=vim
export EDITOR=$VISUAL
export CODESPACE=$HOME/code
export WORKSPACE=$CODESPACE/demandbase

# grep options
export GREP_OPTIONS='--color=auto --exclude-dir=.git'

# set display for x forwarding
export DISPLAY=:0.0

# term
export TERM="xterm-256color-italic"
# TERM=xterm # needed for various urxvt fixes
# stty erase '^?'

# Some flags to help with compilation from source for el capitan
export CPPFLAGS="-I/usr/local/opt/openssl/include"
export LDFLAGS="-L/usr/local/opt/openssl/lib"

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
plugins=(git tmux docker)

source $ZSH/oh-my-zsh.sh

# ================================================================
# USER CONFIGURATIONS
# ================================================================

export CHROME_BIN="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"

# export MANPATH="/usr/local/man:$MANPATH"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/id_rsa"

# ================================================================
# SET USER HOME BIN
# ================================================================
if [ -d "$HOME/bin" ]; then
	export PATH="$HOME/bin:$PATH"
fi

# ================================================================
# GO
# ================================================================
export GOROOT=/usr/local/go
export PATH="$PATH:$GOROOT/bin"
export GOPATH=$HOME/gocode

# ================================================================
# NODEJS
# ================================================================
if test -n "$(command -v npm)"; then
	export NODE_PATH="/usr/local/lib/node_modules:$HOME/node_modules";
	export NPM_PACKAGES="/usr/local/share/npm";
	PATH="$PATH:/usr/local/lib/node_modules/npm/bin:$HOME/node_modules/.bin";
	PATH="$PATH:$NPM_PACKAGES/bin"
fi

# Unset manpath so we can inherit from /etc/manpath via the `manpath`
# command
unset MANPATH # delete if you already modified MANPATH elsewhere in your config
MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

# ================================================================
# GOOGLE CLOUD SDK
# ================================================================

# The next line enables bash completion for gcloud.
# source '$HOME/google-cloud-sdk/completion.bash.inc'

# The next line updates PATH for the Google Cloud SDK.
# source '/Users/bmansfield/google-cloud-sdk/path.zsh.inc'

# ================================================================
# Initialize docker-machine shell variables
# ================================================================
# [ "$(command -v docker-machine)" ] && eval "$(docker-machine env vbox)"

# ================================================================
# LOAD LOCAL ENV
# ================================================================
[ -f "${HOME}"/.env ] && . $HOME/.env

# ================================================================
# WORK STUFF
# ================================================================

# aws
[[ -f ~/.work/.aws ]] && source ~/.work/.aws

# ================================================================
# ImageMagick
# ================================================================
export MAGICK_HOME="$HOME/bin/ImageMagick-7.0.3"

# ================================================================
# PATH
# ================================================================

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$GOPATH/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/Applications/CMake.app/Contents/bin:$PATH"
export PATH="$MAGICK_HOME/bin:$PATH"
export DYLD_LIBRARY_PATH="$MAGICK_HOME/lib/"

# ================================================================
# ALIASES
# ================================================================
[[ -f ~/.aliases ]] && source ~/.aliases

# ================================================================
# FUNCTIONS
# ================================================================
[[ -f ~/.functions ]] && source ~/.functions

# ================================================================
# keychain / GnuPG
# ================================================================

eval $(keychain --nogui --eval --agents ssh --inherit any id_rsa)
export GPGKEY="72F8EAFA"
export GPG_AGENT_INFO
export GPG_TTY=$(tty)

# Load archey
archey

# forgot why it was needed to add this at the end
export PATH="/usr/local/sbin:$PATH"

