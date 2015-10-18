# My own personal dotfiles repo for my Arch + Awesome set up

These are my personal dotfiles to help me sync them between computers and keep them versioned

## Installation

This depends on if you want to symlink everything or if you want to just make
your home directory your repo. 

For symlinking you can do the following:

1. Clone repo to local home directory

```bash
git clone https://github.com/byronmansfield/dotfiles.git $HOME/dotfiles
```

2. Symlink all the files
For brevity I'm not going to show all of these, rather just an example.
Hopefully I'll have a shell script soon that will do all this for you. 

Example:
```shell
ln -s ~/dotfiles/.functions ~/.functions
```

## Tools Used

A short list of some of my favorite tools I use in my shell that I can't live without. I will probably grow this list as I grow as a developer and add in stuff from my other computers.

* URXVT
* Tmux
* Vim
* ZSH
* OH-MY-ZSH

## Personal Configurations

There are a few personalized configurations that I am really fond of and find helpful for my daily hacking

* Tmux copy and paste
* Tmux ressurect
* Z-shell's aliases
* handy functions
* Git config

## $PATH

Short list of tools I must have in my path

* GO
* Node + NPM
* rbenv
* chef
* Docker

# To-Do's

- [ ] write bash script to ease setup
- [ ] convert some of the function to shell scripts in $HOME/bin and include
	them in repo
