if [[ -z $DISPLAY && ! -e /tmp/.X11-unix/X0 && -x /usr/bin/startx ]] && ((EUID)); then
  exec startx
else
  eval $(keychain --nogui --eval --agents gpg,ssh id_rsa 217FD2E8)
fi
