xrandr --output HDMI-A-0 --mode 1920x1080 --rate 60  --primary --left-of eDP &
pipewire &
dbus-run-session dwm
