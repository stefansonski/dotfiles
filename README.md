# dotfiles
This is my personal configuration collection of for me important tools.

## Installation
There are two possible ways to install the scripts, automatically or manual.
The install script currently only supports apt-based distributions and is only
tested on Debian testing.
At the moment the install script is not well tested, so be careful using it!

### Manual
To install the configuration, just link the dotfile/dotfolder associated file
with the proper dotfile/dotfolder in your `$HOME` folder.

1. Clone the repository into your `$HOME` directory.
   ```sh
   git clone git@github.com:stefansonski/dotfiles.git ~/dotfiles
   ```

1. Download and install powerline-gitstatus with pip.
   ```sh
   sudo pip install powerline-gitstatus
   sudo pip3 install powerline-gitstatus
   ```

1. Create soft-links to the files in the repository.
   ```sh
   mkdir -p ~/.local/bin
   mkdir -p ~/.cache/ssh
   mkdir -p ~/.gnupg
   sudo make --directory=/usr/share/doc/git/contrib/credential/gnome-keyring/
   sudo chmod +x /usr/share/doc/git/contrib/diff-highlight/diff-highlight
   ln -s /usr/share/doc/git/contrib/diff-highlight/diff-highlight ~/bin/diff-highlight
   ln -s ~/dotfiles/bin/diffconflicts.sh ~/bin/diffconflicts.sh
   ln -s ~/dotfiles/config ~/.config
   ln -s ~/dotfiles/dircolors ~/.dir_colors
   ln -s ~/dotfiles/dircolors ~/.dircolors
   ln -s ~/dotfiles/gdbinit ~/.gdbinit
   ln -s ~/dotfiles/gitattributes ~/.gitattributes
   ln -s ~/dotfiles/gitconfig ~/.gitconfig
   ln -s ~/dotfiles/globalrc ~/.globalrc
   ln -s ~/dotfiles/gpg.conf ~/.gnupg/gpg.conf
   ln -s ~/dotfiles/ssh/ ~/.ssh
   ln -s ~/dotfiles/weechat ~/.weechat
   ln -s ~/dotfiles/zshenv ~/.zshenv
   ln -s ~/dotfiles/zshrc ~/.zshrc
   curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
   ./dconf-load.sh
   ```

1. To use the nvim configuration, install [vim-plug]
   (https://github.com/junegunn/vim-plug) and run the following command in
   nvim.
   ```sh
   nvim +PlugInstall! +qall
   ```

   1. The installation process can take some time, especially because of the
      build process of YouCompleteMe, which is run on every `:NeoBundleInstall`
      and `:NeoBundleUpdate` and no output is generated.

   1. For debian use the following packages.

      ```sh
      sudo apt install pinentry-curses clang-format powerline python-pip \
         python3-pip python-powerline python3-powerline neovim python-neovim \
         python3-neovim libgnome-keyring-dev fonts-hack-otf zsh ruby-dev \
         golang git-all global
      ```

1. To use powerline, install the powerline package on your system and adapt
   the last line in the `zshrc` to the path of the zsh powerline bindings.

1. Semantic-completion for various programming languages is enabled. This is
   currently the case for C/C++, go, python and rustc. Look at
   [ncm](https://github.com/roxma/nvim-completion-manager) additional plugins
   and build in support for other languages. To enable the completion for
   currently enabled languages run the following commands.

   1. To enable python, install jedi.

      ```sh
      pip install jedi
      pip3 install jedi
      ```

   1. To enable rust support in nvim run

      ```sh
      curl https://sh.rustup.rs -sSf | sh
      rustup component add rustfmt-preview rust-src
      cargo install racer
      ```

   1. To enable golang completion run additionally

      ```sh
      go get github.com/nsf/gocode
      ```

### Automatic
Just run `./install.sh`, all packages are installed, soft-links are created
and nvim plugins are installed. In case files exist, but reference do not
reference the correct file, you are asked if you want to overwrite them.
