# My own personal dotfiles

These are my personal dotfiles to help me sync them between computers and keep them versioned

## Installation

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

* Tmux
* Vim
* Z-shell
* OH-MY-ZSH

## Personal Configurations

There are a few personalized configurations that I am really fond of and find helpful for my daily hacking

* Tmux copy and paste
* Tmux ressurect
* Z-shells aliases
* helpful functions
* Git config

## $PATH

Short list of tools I must have in my path

* GO
* Node + NPM
* rbenv
* Docker

# Extra's

I have found after setting up many new machines that I also need to refind many extra tools that I use all the time that may not directly live in my dotfiles repo so I have started a [wiki](https://github.com/byronmansfield/dotfiles/wiki/MacOS) to remind me how, and where to find and install each of these tools. Please see the [wiki](https://github.com/byronmansfield/dotfiles/wiki/MacOS) to get the full list of additional tools that I typical set up on each new machine.

# To-Do's

- [ ] write shell script to handle symlinking all the files
- [ ] convert some of the function to shell scripts in $HOME/bin and include
	them in repo
