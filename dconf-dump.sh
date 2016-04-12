#!/bin/sh
dconf dump /org/gnome/terminal/ > config/dconf/dconf.d/terminal.conf
dconf dump /org/gnome/GPaste/ > config/dconf/dconf.d/GPaste.conf
dconf dump /org/gnome/desktop/ > config/dconf/dconf.d/desktop.conf
dconf dump /org/gnome/gnome-session/ > config/dconf/dconf.d/session.conf
dconf dump /org/gnome/nautilus/ > config/dconf/dconf.d/nautilus.conf
dconf dump /org/gnome/shell/ > config/dconf/dconf.d/shell.conf
dconf dump /org/gnome/settings-daemon/ > config/dconf/dconf.d/settings-daemon.conf
