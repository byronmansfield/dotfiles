# start urxvt unicode
urxvtd &

# merge Xresources
xrdb -merge ~/.Xresources

# instantiate xrandr saved settings
xrandr --output GPU-0.HDMI-0 --off --output GPU-0.DP-1 --mode 1920x1080 --pos 1920x0 --rotate normal --output GPU-0.DP-2 --off --output GPU-0.DP-3 --off --output GPU-0.DP-4 --off --output GPU-0.DP-5 --off --output GPU-0.DP-1 --off --output GPU-1.DP-3 --off --output GPU-1.DVI-I-1 --off --output GPU-1.DP-3 --mode 1920x1080 --pos 3840x0 --rotate normal --output GPU-1.HDMI-0 --off --output GPU-0.DVI-I-0 --off --output GPU-0.DVI-I-1 --off --output GPU-1.DP-5 --off --output GPU-1.DVI-I-0 --off --output GPU-1.DP-1 --mode 1920x1080 --pos 0x0 --rotate normal --output GPU-1.DP-2 --off --output GPU-1.DP-4 --off

# start xscreensaver
xscreensaver -nosplash &

# start awesome
awesome
