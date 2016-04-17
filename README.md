# My own personal dotfiles repo for my Arch + Awesome set up on a Macbook Pro Laptop

These are my personal dotfiles to help me sync them between computers and keep them versioned

## Installation

1. Initialize home dir to be repo

```shell
git init
```

2. Add remote repo

Example:
```shell
git remote add origin git:github.com:byronmansfield/dotfiles.git
```

3. Switch to correct branch
```shell
git checkout arch-mbpro
```

4. Sync home dir with repo
```shell
git fetch --all
git reset --hard origin/arch-mbpro
```

5. Add new files
```shell
git add -f .somefile
git commit -m "Adds .somefile"
git push
```

## Tools Used

A short list of some of my favorite tools I use in my shell that I can't live without. I will probably grow this list as I grow as a developer and add in stuff from my other computers.

* URxvt
* Tmux
* Vim
* ZSH / OH-MY-ZSH
* gpg
* openssh
* docker
* Weechat
* password-store

## Personal Configurations

There are a few personalized configurations that I am really fond of and find helpful for my daily hacking

* awesome-wm keybindings
* Tmux/URxvt copy and paste
* Tmux ressurect
* Z-shell's aliases
* handy functions
* Git config

## $PATH

Short list of tools I must have in my path

* GO
* Docker
* Node + NPM
* rbenv
* chef

Thats pretty much it. Take what you like, send a PR if you have any
suggestions. Enjoy!

## To-Do

I would like to leave a short list of MacBook Pro specific links I found helpful for the setup. Also a list of vital packages I should install asap.
