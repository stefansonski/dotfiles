#!/bin/sh
cat config/dconf/dconf.d/terminal.conf | dconf load /org/gnome/terminal/
cat config/dconf/dconf.d/GPaste.conf | dconf load /org/gnome/GPaste/
cat config/dconf/dconf.d/desktop.conf | dconf load /org/gnome/desktop/
cat config/dconf/dconf.d/session.conf | dconf load /org/gnome/gnome-session/
cat config/dconf/dconf.d/nautilus.conf | dconf load /org/gnome/nautilus/
cat config/dconf/dconf.d/shell.conf | dconf load /org/gnome/shell/
cat config/dconf/dconf.d/settings-daemon.conf | dconf load /org/gnome/settings-daemon/
