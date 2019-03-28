#!/bin/bash
set -e

function cleanup()
{
  cd $originalDirectory
}

function checkAndInstallConfig()
{
  if [[ $# -lt 2 || -z $1 || -z $2 ]]; then
    printf "Wrong number of arguments.\n"
    cd $originalDirectory
    exit 1
  fi

  destination=$1
  source=$2

  readlinkResult=$(readlink -m $source)

  if [[ -e $source || -h $source ]]; then
    if [[ ! -h $source ]]; then
      printf "\"$source\" exists, but is not a link."
    elif [[ $readlinkResult != $destination ]]; then
      printf "\"$source\" points to the wrong destination "
      printf "(\"$readlinkResult\")."
    else
      printf "$source is correctly linked to $readlinkResult\n"
      return
    fi

    if [[ ! -h $source || $readlinkResult != $destination ]]; then
      printf " Overwrite? [Y/n] "
      read overwrite
      case "$overwrite" in
        ""|"y"|"Y")
          printf "Deleting $source.\n"
          rm -r $source;
          ;;
        "n"|"N")
          printf "Skipping installation $source.\n"
          return
          ;;
        *)
          printf "Invalid input \"$overwrite\". Aborting installation.\n"
          cd $originalDirectory
          exit 1
          ;;
      esac
    fi
  fi

  if [[ ! -e $source && ! -h $source ]]; then
    printf "Creating link \"$source\" to \"$destination\".\n"
    ln -s $destination $source
  fi
}

function checkAndInstallPythonPackages()
{
  if [[ $# -lt 1 || -z $1 ]]; then
    printf "Wrong number of arguments.\n"
    cd $originalDirectory
    exit 1
  fi

  package=$1

  if [[ -z $(pip show $package) ]]; then
    printf "Pip package $package is missing. Install it? [Y/n] "
    read install
    case "$install" in
      ""|"y"|"Y")
        printf "Installing $package with pip.\n"
        sudo pip install $package
        ;;
      "n"|"N")
        printf "Skipping installation. Not all configs may work.\n"
        ;;
      *)
        printf "Invalid input \"$install\". Aborting installation.\n"
        cd $originalDirectory
        exit 1
        ;;
    esac
  fi

  if [[ -z $(pip3 show $package) ]]; then
    printf "Pip3 package $package is missing. Install it? [Y/n] "
    read install
    case "$install" in
      ""|"y"|"Y")
        printf "Installing $package with pip.\n"
        sudo pip3 install $package
        ;;
      "n"|"N")
        printf "Skipping installation. Not all configs may work.\n"
        ;;
      *)
        printf "Invalid input \"$install\". Aborting installation.\n"
        cd $originalDirectory
        exit 1
        ;;
    esac
  fi
}

originalDirectory=`pwd`
cd `dirname $0`
directory=`pwd`
trap cleanup EXIT

neededPackages="fonts-hack-otf git-all libgnome-keyring-dev pinentry-curses powerline python-pip python3-pip clang-tools
                python-powerline python3-powerline neovim python-neovim python3-neovim zsh"

for pkg in $neededPackages; do
  if ! dpkg -s $pkg &> /dev/null; then
    missingPackages="$missingPackages $pkg"
  fi
done

if [[ ! -z $missingPackages ]]; then
  printf "Some of following packages are not installed and are going to be "
  printf "installed with apt:\n"
  printf "$missingPackages"
  printf "\nInstall? [Y/n] "
  read install
  case "$install" in
    ""|"y"|"Y")
      sudo apt install $missingPackages
      ;;
    "n"|"N")
      printf "Skipping installation. Not all configs may work.\n"
      ;;
    *)
      printf "Invalid input \"$install\". Aborting installation.\n"
      cd $originalDirectory
      exit 1
      ;;
  esac
fi

checkAndInstallPythonPackages powerline-gitstatus

#if ! command -v rustup; then
#  curl https://sh.rustup.rs | bash -s -- --no-modify-path -y
#  source ~/.cargo/env
#  mkdir -p ~/.zfunc
#  rustup completions zsh > ~/.zfunc/_rustup
#fi
#
#rustup update
#rustup component add rls rust-analysis rust-src

printf "Creating links.\n"
mkdir -p ~/.local/bin
mkdir -p ~/.cache/ssh
mkdir -p ~/.gnupg
sudo make --directory=/usr/share/doc/git/contrib/credential/gnome-keyring/
sudo make --directory=/usr/share/doc/git/contrib/diff-highlight/
checkAndInstallConfig /usr/share/doc/git/contrib/diff-highlight/diff-highlight ~/.local/bin/diff-highlight
checkAndInstallConfig $directory/config ~/.config
checkAndInstallConfig $directory/dircolors ~/.dir_colors
checkAndInstallConfig $directory/dircolors ~/.dircolors
checkAndInstallConfig $directory/gdbinit ~/.gdbinit
checkAndInstallConfig $directory/gitattributes ~/.gitattributes
checkAndInstallConfig $directory/gitconfig ~/.gitconfig
checkAndInstallConfig $directory/gpg.conf ~/.gnupg/gpg.conf
checkAndInstallConfig $directory/spacemacs ~/.spacemacs
checkAndInstallConfig $directory/ssh ~/.ssh
checkAndInstallConfig $directory/weechat ~/.weechat
checkAndInstallConfig $directory/zshenv ~/.zshenv
checkAndInstallConfig $directory/zshrc ~/.zshrc

printf "Loading dconf configuration.\n"
./dconf-load.sh

if [[ ! -a ~/.config/nvim/autoload/plug.vim ]]; then
  curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

printf "Installing/updating neovim plugins via vim-plug.\n"
nvim +PlugInstall! +qall

cd $originalDirectory
printf "Done.\n"
