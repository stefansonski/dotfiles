# dotfiles
This is my personal configuration collection of for me important tools.

## Installation
To install the configuration, just link the dotfile/dotfolder associated file
with the proper dotfile/dotfolder in your `$HOME` folder.

1. Clone the repository into your `$HOME` directory.
   ```sh
   git clone git@github.com:stefansonski/dotfiles.git ~/dotfiles
   ```

1. Download and install powerline-gitstatus with pip.
   ```sh
   sudo pip install powerline-gitstatus
   ```

1. Create soft-links to the files in the repository.
   ```sh
   ln -s ../../githooks/* .git/hooks/
   mkdir -p ~/.cache/ssh/mux
   mkdir -p ~/.gnupg
   mkdir -p ~/.vim/bundle
   mkdir -p ~/.vim/spell
   ln -s ~/dotfiles/dircolors ~/.dircolors
   ln -s ~/dotfiles/gdbinit ~/.gdbinit
   ln -s ~/dotfiles/gitconfig ~/.gitconfig
   ln -s ~/dotfiles/gitignore ~/.gitignore
   ln -s ~/dotfiles/gittemplate ~/.gittemplate
   ln -s ~/dotfiles/contrib/whiteinge-dotfiles/bin/diffconflicts ~/bin/diffconflicts.sh
   ln -s ~/dotfiles/gpg.conf ~/.gnupg/gpg.conf
   ln -s ~/dotfiles/globalrc ~/.globalrc
   ln -s ~/dotfiles/gradle ~/.gradle
   ln -s ~/dotfiles/config ~/.config
   ln -s ~/dotfiles/ssh/ ~/.ssh
   ln -s ~/dotfiles/vimrc ~/.vimrc
   ln -s ~/dotfiles/vimspell-en.utf-8.add ~/.vim/spell/en.utf-8.add
   ln -s ~/dotfiles/zshenv ~/.zshenv
   ln -s ~/dotfiles/zshrc ~/.zshrc
   git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
   cat config/dconf/user.dump | dconf load /
   ```

1. To use the vim configuration, install [NeoBundle]
   (https://github.com/Shougo/neobundle.vim) and run the following command in
   vim.
   ```vim
   :NeoBundleInstall
   ```

   1. The installation process can take some time, especially because of the
      build process of YouCompleteMe, which is run on every `:NeoBundleInstall`
      and `:NeoBundleUpdate` and no output is generated.

   1. For YouCompleteMe to work with C/C++ support an appropriate clang version
      and boost dev-packages have to be available (Debian Jessie and Testing is
      working). If the build is failing, see the README of
      [YouCompleteMe](https://github.com/Valloric/YouCompleteMe).
      For debian use the following packages.

      ```sh
      sudo apt install llvm-dev libboost-dev libboost-python-dev \
      libboost-filesystem-dev libboost-system-dev libboost-regex-dev \
      libboost-thread-dev
      ```

   1. To use vim-clang-format in vim, install a clang-format package with
      version 3.4 or greater. On Debian install package `clang-format` which
      downloads the current default version.

1. To use powerline, install the powerline package on your system and adapt
   the last line in the `zshrc` to the path of the zsh powerline bindings.

1. To use the solarized colors in gnome-terminal, run `./install.sh` in the
   submodule-folder _contrib/gnome-terminal-colors-solarized_.

1. For dircolors with other solarized color schemes than solarized-dark, use
   one of [dircolors-solarized](https://github.com/seebi/dircolors-solarized)
   dircolors and exchange it with dircolors.
