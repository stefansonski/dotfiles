# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/games:/usr/games"

# basedir defaults, in case they're not already set up.
# http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
if [[ -z $XDG_DATA_HOME ]]; then
  export XDG_DATA_HOME=$HOME/.local/share
fi

if [[ -z $XDG_CONFIG_HOME ]]; then
  export XDG_CONFIG_HOME=$HOME/.config
fi

if [[ -z $XDG_CACHE_HOME ]]; then
  export XDG_CACHE_HOME=$HOME/.cache
fi

if [[ -z $XDG_DATA_DIRS ]]; then
  export XDG_DATA_DIRS=/usr/local/share:/usr/share
fi

if [[ -z $XDG_CONFIG_DIRS ]]; then
  export XDG_CONFIG_DIRS=/etc/xdg
else
  export XDG_CONFIG_DIRS=/etc/xdg:$XDG_CONFIG_DIRS
fi

#Add arm-toolchain to PATH
if [ -d "/opt/arm-toolchain/bin" ]; then
  export PATH="/opt/arm-toolchain/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
  export PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/tools/android-sdk" ] ; then
  export ANDROID_HOME="$HOME/tools/android-sdk"
fi

if [ -d "$ANDROID_HOME/tools" ] ; then
  export PATH="$ANDROID_HOME/tools:$PATH"
fi

if [ -d "$ANDROID_HOME/platform-tools" ] ; then
  export PATH="$ANDROID_HOME/platform-tools:$PATH"
fi

if [ -d "$HOME/.go" ]; then
  export GOPATH="$HOME/.go"
  export PATH="$GOPATH/bin:$PATH"
fi

if [ -d "$HOME/.cargo" ]; then
  export PATH="$HOME/.cargo/bin:$PATH"
  export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
fi

if [ -d "$HOME/tools/neovim" ]; then
  export PATH="$HOME/tools/neovim/bin:$PATH"
fi

if [ -d "$HOME/tools/neovim-qt" ]; then
  export PATH="$HOME/tools/neovim-qt/bin:$PATH"
fi

export GPG_TTY=$(tty)
if [[ -n "$SSH_CONNECTION" ]] ;then
  export PINENTRY_USER_DATA="USE_CURSES=1"
fi

export EDITOR=$(which vim)
export VISUAL=$EDITOR
export PAGER=$(which less)
export LESS="-FRX"
export GTAGSLABEL="default"
