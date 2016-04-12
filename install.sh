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
      cd $originalDirectory
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
      cd $originalDirectory
      exit 1
      ;;
  esac
fi

printf "Creating links.\n"
mkdir -p ~/.cache/ssh/mux
mkdir -p ~/.gnupg
mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/spell
checkAndInstallConfig $directory/dircolors ~/.dircolors
checkAndInstallConfig $directory/gdbinit ~/.gdbinit
checkAndInstallConfig $directory/gitconfig ~/.gitconfig
checkAndInstallConfig $directory/gittemplate ~/.gittemplate
checkAndInstallConfig $directory/bin/diffconflicts.sh ~/bin/diffconflicts.sh
checkAndInstallConfig $directory/gpg.conf ~/.gnupg/gpg.conf
checkAndInstallConfig $directory/globalrc ~/.globalrc
checkAndInstallConfig $directory/gradle ~/.gradle
checkAndInstallConfig $directory/config ~/.config
checkAndInstallConfig $directory/ssh ~/.ssh
checkAndInstallConfig $directory/vimrc ~/.vimrc
checkAndInstallConfig $directory/vimspell-en.utf-8.add ~/.vim/spell/en.utf-8.add
checkAndInstallConfig $directory/zshenv ~/.zshenv
checkAndInstallConfig $directory/zshrc ~/.zshrc

printf "Loading dconf configuration.\n"
./dconf-load.sh

if [[ ! -a ~/.vim/bundle/neobundle.vim ]]; then
  printf "Checking out NeoBundle for vim.\n"
  git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
fi

printf "Installing/updating vim plugins via NeoBundle.\n"
vim +NeoBundleInstall! +qall

cd $originalDirectory
printf "Done.\n"