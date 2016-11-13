# My own personal dotfiles repo for my Arch + Awesome set up

These are my personal dotfiles to help me sync them between computers and keep them versioned

## Installation

I usually make this my home directory and then ignore everything by default in
the `.gitignore`. This makes it so you have to `git add -f <some-file>`

You can clone repo to local home directory

```bash
git clone https://github.com/byronmansfield/dotfiles.git $HOME
```

Or, alternatly you can

```bash
git init
git remote set-url origin https://github.com/byronmansfield/dotfiles.git
git pull
git checkout arch
```

## Tools Used

A short list of some of my favorite tools I use in my shell that I can't live without. I will probably grow this list as I grow as a developer and add in stuff from my other computers.

* URxvt
* Tmux
* Vim
* ZSH
* OH-MY-ZSH
* Weechat

## Personal Configurations

There are a few personalized configurations that I am really fond of and find helpful for my daily hacking

* Tmux/URxvt copy and paste
* Tmux ressurect
* Z-shell's aliases
* handy functions
* Git config

## $PATH

Short list of tools I must have in my path

* GOlang
* Docker
* Node + NPM
* rvm
* chef

Thats pretty much it. Take what you like, send a PR if you have any
suggestions. Enjoy!

# Other

I know there are some vim things listed here, checkout my [dotvim](https://github.com/byronmansfield/dotvim) repo for the
complete list of my vim interface

