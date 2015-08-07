#!/bin/sh

# ================================================================
# GO SETTINGS
# ================================================================
# Set GOPATH if missing
if [ -z "${GOPATH}" ]; then
  export GOPATH=/usr/local/go
  export PATH=$PATH:$GOPATH/bin
fi
