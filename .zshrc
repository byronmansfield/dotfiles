# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# set theme
ZSH_THEME="byron"

# Set vim as default editor
export VISUAL=vim
export EDITOR=$VISUAL
export CODESPACE=$HOME/code
export WORKSPACE=$CODESPACE/Demandbase

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

export CHROME_BIN="/usr/bin/google-chrome-unstable"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
fi

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

## ================================================================
# NODEJS & NPM
# ================================================================
if test -n "$(command -v npm)"; then
	export NODE_PATH="/usr/local/bin/node"
	export NPM_PATH="/usr/local/bin/npm"
	export NODE_MODULES="$HOME/node_modules"
	export NPM_PACKAGES="$HOME/.npm-packages"
  export PATH="$PATH:$NPM_PACKAGES/bin:$NODE_MODULES/.bin"
fi

# ================================================================
# GOOGLE CLOUD SDK
# ================================================================

# The next line updates PATH for the Google Cloud SDK.
# source '$HOME/google-cloud-sdk/path.bash.inc'

# The next line enables bash completion for gcloud.
# source '$HOME/google-cloud-sdk/completion.bash.inc'

# ================================================================
# LOAD LOCAL ENV
# ================================================================
[ -f "${HOME}"/.env ] && . $HOME/.env

# ================================================================
# WORK STUFF
# ================================================================

# aws
[[ -f ~/.work/.aws ]] && source ~/.work/.aws

# other work related exports i need for projects
[[ -f ~/.work/.exports ]] && source ~/.work/.exports

# set chef repo
export CHEF_REPO=$HOME/code/Demandbase/chef-repo

# ================================================================
# PATH
# ================================================================

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$GOPATH/bin:$PATH"

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

# ================================================================
# RBENV
# ================================================================
export PATH="$PATH:$HOME/.rbenv/bin"
eval "$(rbenv init -)"

# Load archey (if installed)
if test -n "$(command -v archey3)"; then
  archey3
fi

