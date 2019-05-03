## resolution
#xrandr --output eDP-1 --mode 1920x1080 &
#xrandr --output eDP-1 --scale 0.90x0.90 &

## GNOME PolicyKit and Keyring
eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg) &

## Set root window colour
hsetroot -fill ~/.config/i3/wallpaper.png

## Enable transparancy
(sleep 2s && xcompmgr) &

## NetworkManager Applet
(sleep 2s && nm-applet) &

## Volume control for systray
(sleep 2s && pulseaudio) &

## Detect and configure touchpad. See 'man synclient' for more info.
xinput --set-prop 12 "Synaptics Scrolling Distance" -30 -30 &

## Start Clipboard manager
(sleep 3s && clipit) &

## Set keyboard settings - 250 ms delay and 25 cps (characters per second) repeat rate.
## Adjust the values according to your preferances.
xset r rate 250 25 &

## Turn on/off system beep
xset b off &

## Keyboard-layout
(sleep 3s && setxkbmap -layout us -variant altgr-intl -option nodeadkeys -option ctrl:nocaps) &

## Xflux
redshift -l 59.9494:10.7564 -t 6500:6000 &

# Autostart the Dropbox deamon
(sleep 2s && dropbox start) &

# Autostart slack
(sleep 2s && slack) &

# Autostart conky
(sleep 2s && conky -b) &
