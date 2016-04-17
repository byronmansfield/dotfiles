# start urxvt unicode
urxvtd &

# merge Xresources
xrdb -merge ~/.Xresources

# instantiate xrandr saved settings
xrandr --dpi 160 --output DP-2 --scale 0.8x0.8

# start xscreensaver
xscreensaver -nosplash &

# start awesome
awesome
