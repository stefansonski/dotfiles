# dotfiles
This is my personal configuration collection of for me important tools.

## Installation
To install the configuration, just link the dotfile/dotfolder associated file
with the proper dotfile/dotfolder in your
$HOME folder.

1. Clone the repository into yout $HOME directory.

   ```
   git clone git@github.com:stefansonski/dotfiles.git $HOME/dotfiles
   ```
2. Create softlinks to the files in the repository.

   ```sh
   cd $HOME
   ln -s dotfiles/bash_aliases .bash_aliases
   ln -s dotfiles/bash_profile .bash_profile
   ln -s dotfiles/bashrc .bashrc
   ln -s dotfiles/bin bin
   ln -s dotfiles/gdbinit .gdbinit
   ln -s dotfiles/gitconfig .gitconfig
   ln -s dotfiles/gpg.conf .gnupg/gpg.conf
   ln -s dotfiles/ssh/ .ssh
   ln -s dotfiles/subversion/ .subversion
   ln -s dotfiles/vimrc .vimrc
   mkdir .vim
   ln -s dotfiles/ycm_global_extra_conf.py .vim/
   ```
3. To use the vim configuration, install [Vundle]
   (https://github.com/gmarik/Vundle.vim) and run `vim :PluginInstall` to
   install the plugins.
4. To see the complete guide of how to configure [YouCompleteMe]
   (https://github.com/Valloric/YouCompleteMe) see its README. The easiest way
   is to install clang (e.g. `apt-get install clang`) and run
   `cd $HOME/.vim/bundle/YouCompleteMe` and
   `./install.sh --clang-completer --system-libclang`. For this to work an
   appropiate clang version has to be available (Debian Jessie is working). If
   the build is failing, see the README of YouCompleteMe.
