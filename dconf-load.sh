#!/bin/sh
set -e

originalDirectory=`pwd`
cd `dirname $0`
directory=`pwd`
cd $originalDirectory

cat $directory/config/dconf/dconf.d/terminal.conf | dconf load /org/gnome/terminal/
cat $directory/config/dconf/dconf.d/desktop.conf | dconf load /org/gnome/desktop/
cat $directory/config/dconf/dconf.d/settings-daemon.conf | dconf load /org/gnome/settings-daemon/
