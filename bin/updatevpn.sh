#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

# help text for how to use
function useage() {
  echo "Welcome to VPN helper."
  echo ""
  echo "I got tired of updating my vpn so I made this."
  echo "Note: It does expect you to have your old vpns saved in a certain way"
  echo ""
  echo ""
  echo "Usage:"
  echo ""
  echo "      updatevpn command [arguments]"
  echo ""
  echo "The commands are:"
  echo ""
  echo "    -u      update your old one with a new shiny one. arguments: location of your new vpn zip file [required], which environment is it for [required] - options: [prod, staging, int, dev]"
  echo ""
  echo "example: ./updatevpn.sh -u ~/Desktop/name.zip staging"
  echo ""
  echo ""
}

# unzip vpn file
function unzip() {
  local file="${1##*/}"
  local name="${file%.*}"
  local ext="${file##*.}"
  local envdir=$2
  local today=`date +_%Y_%m_%d`

  # move and rename the old vpn directory and tgz with date suffix to backup directory
  mv ~/Documents/vpns/current/$envdir/$name/* ~/Documents/vpns/old_vpns/$envdir/$name$today
  mv ~/Documents/vpns/current/$envdir/$file ~/Documents/vpns/old_vpns/$envdir/$name$today.$ext

  # move the new vpn to the current directory
  mv $1 ~/Documents/vpns/current/$envdir/

  # extract the file
  tar zxvf ~/Documents/vpns/current/$envdir/$file

  # rename the conf file to match environment
  mv ~/Documents/vpns/current/$envdir/$name/$name.conf ~/Documents/vpns/current/$envdir/$name/$envdir.conf

  # open conf file with tunnelblick
  open -a ~/Applications/Tunnelblick.app ~/Documents/vpns/current/$envdir/$name/$envdir.conf

  exit 0
}

# parse options
while test $# -gt 0; do
  case "$1" in
    -h|--help)
      useage
      exit 0
      ;;
    -u|--update)
      shift
      if test $# -gt 0; then
        if test $# -gt 1; then
          unzip $1 $2
        else
          echo "Please pass the vpn environement (e.g. prod, staging, int, dev)"
        fi
      else
        echo "no file specified"
        exit 1
      fi
      shift
      ;;
    \?)
      echo "Invalid option: $1"
      exit 0
      ;;
  esac
done 
