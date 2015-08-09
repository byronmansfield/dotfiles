#!/bin/bash

# if .profile exists then source it
if [ -f "$HOME/.profile" ]; then
	. "$HOME/.profile"
fi

# if running bash include .bashrc if exists
if [ -n "$BASH_VERSION" ]; then
	if [ -f "$HOME/.bashrc" ]; then
		. "$HOME/.bashrc"
	fi
fi
