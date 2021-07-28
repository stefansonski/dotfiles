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

1. Download and install powerline-gitstatus and powerline-treesitter with pip.
   ```sh
   sudo pip install powerline-gitstatus powerline-treesitter
   sudo pip3 install powerline-gitstatus powerline-treesitter
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
   ln -s ~/dotfiles/gpg.conf ~/.gnupg/gpg.conf
   ln -s ~/dotfiles/ssh/ ~/.ssh
   ln -s ~/dotfiles/spacemacs ~/.spacemacs
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
      sudo apt install fonts-hack-otf git-all libgnome-keyring-dev
        pinentry-curses powerline python-pip python3-pip clang-tools
        python-powerline python3-powerline neovim python-neovim python3-neovim
        zsh
      ```

1. To use powerline, install the powerline package on your system and adapt
   the last line in the `zshrc` to the path of the zsh powerline bindings.

1. `nvim-lspconfig` is configured for various programming languages for lint- and code-completion features.
   To support all the configured languages run the following commands. Look into
   [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md) for additional supported languages.
   Download and install needed language servers using the corresponding package managers.

   ```sh
   pip install cmake-language-server
   pip3 install cmake-language-server
   sudo npm i -g bash-language-server dockerfile-language-server-nodejs pyright vscode-json-languageserver yaml-language-server
   curl https://sh.rustup.rs -sSf | sh
   rustup install nightly
   rustup +nightly component add rust-analyzer-preview rust-src
      ```

### Automatic
Just run `./install.sh`, all packages are installed, soft-links are created
and nvim plugins are installed. In case files exist, but reference do not
reference the correct file, you are asked if you want to overwrite them.
