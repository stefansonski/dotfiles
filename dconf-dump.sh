#!/bin/sh
set -e

originalDirectory=`pwd`
cd `dirname $0`
directory=`pwd`
cd $originalDirectory

dconf dump /org/gnome/terminal/ > $directory/config/dconf/dconf.d/terminal.conf
dconf dump /org/gnome/GPaste/ > $directory/config/dconf/dconf.d/GPaste.conf
dconf dump /org/gnome/desktop/ > $directory/config/dconf/dconf.d/desktop.conf
dconf dump /org/gnome/gnome-session/ > $directory/config/dconf/dconf.d/session.conf
dconf dump /org/gnome/nautilus/ > $directory/config/dconf/dconf.d/nautilus.conf
dconf dump /org/gnome/shell/ > $directory/config/dconf/dconf.d/shell.conf
dconf dump /org/gnome/settings-daemon/ > $directory/config/dconf/dconf.d/settings-daemon.conf
