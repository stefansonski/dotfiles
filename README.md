# dotfiles
This is my personal configuration collection of for me important tools.

## Installation
To install the configuration, just link the dotfile/dotfolder associated file
with the proper dotfile/dotfolder in your $HOME folder.

1. Clone the repository into your $HOME directory.

   ```
   git clone git@github.com:stefansonski/dotfiles.git ~/dotfiles
   ```
1. Download and install powerline-gitstatus with pip.
   ```sh
   sudo pip install powerline-gitstatus
   ```
1. Create soft-links to the files in the repository.

   ```sh
   mkdir -p ~/.gnupg
   mkdir -p ~/.config
   mkdir -p ~/.vim/spell
   ln -s ~/dotfiles/bin $/bin
   ln -s ~/dotfiles/gdbinit ~/.gdbinit
   ln -s ~/dotfiles/gitconfig ~/.gitconfig
   ln -s ~/dotfiles/gitignore ~/.gitignore
   ln -s ~/dotfiles/gittemplate ~/.gittemplate
   ln -s ~/dotfiles/gpg.conf ~/.gnupg/gpg.conf
   ln -s ~/dotfiles/powerline ~/.config/powerline
   ln -s ~/dotfiles/ssh/ ~/.ssh
   ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
   ln -s ~/dotfiles/tmux.conf.locale ~/.tmux.conf.local
   ln -s ~/dotfiles/vimrc ~/.vimrc
   ln -s ~/dotfiles/vimspell-en.utf-8.add ~/.vim/spell/en.utf-8.add
   ln -s ~/dotfiles/ycm_global_extra_conf.py ~/.vim/
   ln -s ~/dotfiles/zshenv ~/.zshenv
   ln -s ~/dotfiles/zshrc ~/.zshrc
   ```
1. To use the vim configuration, install [Vundle]
   (https://github.com/gmarik/Vundle.vim) and run `vim :PluginInstall` to
   install the plugins.
1. To see the complete guide of how to configure [YouCompleteMe]
   (https://github.com/Valloric/YouCompleteMe) see its README. The easiest way
   is to install clang (e.g. `apt-get install clang`) and run
   `cd ~/.vim/bundle/YouCompleteMe` and
   `./install.sh --clang-completer --system-libclang`. For this to work an
   appropriate clang version has to be available (Debian Jessie is working). If
   the build is failing, see the README of YouCompleteMe.
1. To use powerline, install the powerline package on your system and adapt the
   last line in the `zshrc` to the path of the zsh powerline bindings.
1. To use the solarized colors in gnome-terminal, run `./install.sh` in the
   submodule-folder _gnome-terminal/gnome-terminal-colors-solarized_.
1. For dircolors with solarized colors, nothing needs to be done, if the cloned
   directory is named dotfiles and is placed in `$HOME` otherwise the
   corresponding line in `zshrc` needs to be adapted.
