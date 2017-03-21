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

originalDirectory=`pwd`
cd `dirname $0`
directory=`pwd`
trap cleanup EXIT

neededPackages="pinentry-curses llvm-dev libboost-dev libboost-python-dev
                libboost-filesystem-dev libboost-system-dev libboost-regex-dev
                libboost-thread-dev clang clang-format powerline python-pip
                python3-pip python-powerline python3-powerline neovim
                python3-neovim libgnome-keyring-dev fonts-hack-otf zsh ruby-dev"

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

if [[ -z $(pip show powerline-gitstatus) ]]; then
  printf "Pip package powerline-gitstatus is missing. Install it? [Y/n] "
  read install
  case "$install" in
    ""|"y"|"Y")
      printf "Installing powerline-gitstatus with pip.\n"
      sudo pip install powerline-gitstatus
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

if [[ -z $(pip3 show powerline-gitstatus) ]]; then
  printf "Pip3 package powerline-gitstatus is missing. Install it? [Y/n] "
  read install
  case "$install" in
    ""|"y"|"Y")
      printf "Installing powerline-gitstatus with pip.\n"
      sudo pip3 install powerline-gitstatus
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

printf "Creating links.\n"
mkdir -p ~/bin
mkdir -p ~/.cache/ssh/mux
mkdir -p ~/.gnupg
sudo chmod +x /usr/share/doc/git/contrib/diff-highlight/diff-highlight
sudo make --directory=/usr/share/doc/git/contrib/credential/gnome-keyring/
checkAndInstallConfig /usr/share/doc/git/contrib/diff-highlight/diff-highlight ~/bin/diff-highlight
checkAndInstallConfig $directory/dircolors ~/.dircolors
checkAndInstallConfig $directory/gdbinit ~/.gdbinit
checkAndInstallConfig $directory/gitattributes ~/.gitattributes
checkAndInstallConfig $directory/gitconfig ~/.gitconfig
checkAndInstallConfig $directory/githooks ~/.githooks
checkAndInstallConfig $directory/bin/diffconflicts.sh ~/bin/diffconflicts.sh
checkAndInstallConfig $directory/gpg.conf ~/.gnupg/gpg.conf
checkAndInstallConfig $directory/globalrc ~/.globalrc
checkAndInstallConfig $directory/gradle ~/.gradle
checkAndInstallConfig $directory/config ~/.config
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
