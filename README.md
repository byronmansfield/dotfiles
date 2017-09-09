# My own personal dotfiles

These are my personal dotfiles to help me sync them between computers and keep them versioned

## Installation

1. Initialize blank git repo
```bash
git init
```

2. Add remote
```bash
git remote add origin git@github.com:byronmansfield/dotfiles.git
```

3. Fetch Origin
```bash
git fetch origin trusty
```

4. Reset local to head of desired branch
"This helps us overwrite the local files that might already exist. You may want to skip this step and use something like `git stash` if you don't want to overwrite the existing local files. These steps are written under the assumption you are setting up a new machine or container and don't care about the defails"
```bash
git reset --hard origin/trusty
```

5. Pull the actual code from remote
```bash
git pull origin trusty
```

That's it. Enjoy!

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

