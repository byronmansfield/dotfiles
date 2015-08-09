# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Set vim as default editor
export VISUAL=vim
export EDITOR=$VISUAL

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

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

export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin"

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# ================================================================
# SET USER HOME BIN
# ================================================================
if [ -d "$HOME/bin" ]; then
	export PATH="$HOME/bin:$PATH"
fi

# ================================================================
# GO
# ================================================================
if [ -z "${GOPATH}" ]; then
  export GOPATH=/usr/local/go
  export PATH="$PATH:$GOPATH/bin"
fi

## ================================================================
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
# RBENV
# ================================================================
[ "$(command -v rbenv)" ] && eval "$(rbenv init -)"

# ================================================================
# RVM SETUP
# ================================================================
# Since switching from rvm to rbenv I have commented this out
# export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# ================================================================
# GOOGLE CLOUD SDK
# ================================================================

# The next line updates PATH for the Google Cloud SDK.
# source '$HOME/google-cloud-sdk/path.bash.inc'

# The next line enables bash completion for gcloud.
# source '$HOME/google-cloud-sdk/completion.bash.inc'

# ================================================================
# INITIALIZE boot2docker shell variables
# ================================================================
[ "$(command -v boot2docker)" ] \
  && [ "$(ps ax | grep boot2docker-vm | grep -v "grep")" ] \
    && $(boot2docker shellinit 2> /dev/null)

[ "$(command -v docker-machine)" ] && eval "$(docker-machine env vbox)"

# ================================================================
# LOAD LOCAL ENV
# ================================================================
[ -f "${HOME}"/.env ] && source $HOME/.env

# ================================================================
# WORK STUFF
# ================================================================

# aws
[[ -f ~/.work/.aws ]] && source ~/.work/.aws

# chef
export TESTKITCHEN_EC2_PEM=$HOME/.ssh/testkitchen.pem

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# ================================================================
# ALIASES
# ================================================================
[[ -f ~/.aliases ]] && source ~/.aliases

# ================================================================
# FUNCTIONS
# ================================================================
[[ -f ~/.functions ]] && source ~/.functions
