# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

PATH="$PATH:/usr/local/sbin:/usr/sbin:/sbin/"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/tools/android-studio/bin" ] ; then
    PATH="$PATH:$HOME/tools/android-studio/bin"
fi

if [ -d "$HOME/tools/android-sdk-linux/tools" ] ; then
    PATH="$PATH:$HOME/tools/android-sdk-linux/tools"
fi

if [ -d "$HOME/tools/android-sdk-linux/platform-tools" ] ; then
    PATH="$PATH:$HOME/tools/android-sdk-linux/platform-tools"
fi

#Add arm-toolchain to PATH
if [ -d "/opt/arm-toolchain/bin" ]; then
    PATH="$PATH:/opt/arm-toolchain/bin"
fi

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

export EDITOR=$(which vim)
