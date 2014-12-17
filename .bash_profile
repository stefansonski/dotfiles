# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

export HISTTIMEFORMAT="%y/%m/%d %T "
export GOPATH=$HOME/.gocode

export PATH="$PATH:/usr/local/sbin:/usr/sbin:/sbin/"
export PATH="$PATH:$HOME/tools/android-studio/bin"
export PATH="$PATH:$HOME/tools/android-sdk-linux/tools"
export PATH="$PATH:$HOME/tools/android-sdk-linux/platform-tools"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    export PATH="$HOME/bin:$PATH"
fi

#Add arm-toolchain to PATH
if [ -d "/opt/arm-toolchain/bin" ]; then
    export PATH=$PATH:/opt/arm-toolchain/bin
fi
