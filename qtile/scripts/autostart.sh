#!/bin/bash

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
xscreensaver &
variety &
telegram-desktop -startintray &
#nitrogen --restore &
flameshot &
picom --config $HOME/.config/qtile/scripts/picom.conf &
cairo-dock &
