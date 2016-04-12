#!/bin/bash
set -e

function checkAndInstallConfig()
{
  if [[ $# -lt 2 || -z $1 || -z $2 ]]; then
    printf "Wrong number of arguments.\n"
    exit 1
  fi

  destination=$1
  source=$2

  if [[ -a $source ]]; then
    readlinkResult=$(readlink -f $source)
  fi

  if [[ ! -h $source ]]; then
    printf "\"$source\" exists, but is not a link."
  elif [[ $readlinkResult != $destination ]]; then
    printf "\"$source\" points to the wrong destination (\"$readlinkResult\")."
  fi

  if [[ -a $source && (! -h $source || $readlinkResult != $destination) ]]; then
    printf " Overwrite? [Y/n] "
    read overwrite
    case "$overwrite" in
      ""|"y"|"Y")
        printf "Deleting $source.\n"
        rm -rf $source;
        ;;
      "n"|"N")
        printf "Skipping installation $source.\n"
        return
        ;;
      *)
        printf "Invalid input \"$overwrite\". Aborting installation.\n"
        exit 1
        ;;
    esac
    printf "Creating link \"$source\" to \"$destination\".\n"
    ln -s $destination $source
  fi
}

neededPackages="llvm-dev libboost-dev libboost-python-dev
                libboost-filesystem-dev libboost-system-dev
                libboost-regex-dev libboost-thread-dev clang clang-format
                powerline python-pip"

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
      exit 1
      ;;
  esac
fi

if [[ -z $(pip show powerline-status) ]]; then
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
      exit 1
      ;;
  esac
fi

printf "Creating links.\n"
mkdir -p ~/.cache/ssh/mux
mkdir -p ~/.gnupg
mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/spell
checkAndInstallConfig ~/dotfiles/dircolors ~/.dir_colors
checkAndInstallConfig ~/dotfiles/gdbinit ~/.gdbinit
checkAndInstallConfig ~/dotfiles/gitconfig ~/.gitconfig
checkAndInstallConfig ~/dotfiles/gittemplate ~/.gittemplate
checkAndInstallConfig ~/dotfiles/bin/diffconflicts.sh ~/bin/diffconflicts.sh
checkAndInstallConfig ~/dotfiles/gpg.conf ~/.gnupg/gpg.conf
checkAndInstallConfig ~/dotfiles/globalrc ~/.globalrc
checkAndInstallConfig ~/dotfiles/gradle ~/.gradle
checkAndInstallConfig ~/dotfiles/config ~/.config
checkAndInstallConfig ~/dotfiles/ssh ~/.ssh
checkAndInstallConfig ~/dotfiles/vimrc ~/.vimrc
checkAndInstallConfig ~/dotfiles/vimspell-en.utf-8.add ~/.vim/spell/en.utf-8.add
checkAndInstallConfig ~/dotfiles/zshenv ~/.zshenv
checkAndInstallConfig ~/dotfiles/zshrc ~/.zshrc

printf "Loading dconf configuration.\n"
./dconf-load.sh

if [[ ! -a ~/.vim/bundle/neobundle.vim ]]; then
  printf "Checking out NeoBundle for vim.\n"
  git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
fi

printf "Installing/updating vim plugins via NeoBundle.\n"
vim +NeoBundleInstall! +qall

printf "Done.\n"
