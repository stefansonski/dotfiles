#
# .zshrc is sourced in interactive shells.
# It should contain commands to set up aliases,
# functions, options, key bindings, etc.
#
#  Not all terminals support this and, of those that do,
#  not all provide facilities to test the support, hence
#  the user should decide based on the terminal type.  Most
#  terminals  support the  colours  black,  red,  green,
#  yellow, blue, magenta, cyan and white, which can be set
#  by name.  In addition. default may be used to set the
#  terminal's default foreground colour.  Abbreviations
#  are allowed; b or bl selects black.
#

#source /usr/share/zsh-antigen/antigen.zsh

## use oh-my-zsh as standard repo
#antigen bundle command-not-found

## apply antigen plugins
#antigen apply

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
WORDCHARS="${WORDCHARS:s#/#}"
WORDCHARS="${WORDCHARS:s#.#}"

##############################################################
#key binding stuff to get the right keys to work
# key bindings
bindkey -e
bindkey "${key[Home]}" beginning-of-line
bindkey "${key[End]}" end-of-line
bindkey "${key[Delete]}" delete-char
bindkey "${key[Insert]}" overwrite-mode
bindkey ";5C" forward-word
bindkey ";5D" backward-word

# search history with pattern
bindkey "^R" history-incremental-pattern-search-backward
bindkey "^S" history-incremental-pattern-search-forward

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "${key[Up]}" up-line-or-beginning-search # Up
bindkey "${key[Down]}" down-line-or-beginning-search # Down
bindkey ";5A" up-line-or-beginning-search # Up
bindkey ";5B" down-line-or-beginning-search # Down

autoload -Uz compinit
compinit

# End of lines added by compinstall
## completion system
_force_rehash() {
  (( CURRENT == 1 )) && rehash
  return 1  # Because we didn't really complete anything
}

zstyle ':completion:*' completer _oldlist _expand _force_rehash _complete _approximate _expand_alias
zstyle ':completion:*:approximate:'    max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )' # allow one error for every three characters typed in approximate completer
zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~' # don't complete backup files as executables
zstyle ':completion:*:correct:*'       insert-unambiguous true             # start menu completion only if it could find no unambiguous initial string
zstyle ':completion:*:corrections'     format $'%{\e[0;31m%}%d (errors: %e)%{\e[0m%}' #
zstyle ':completion:*:correct:*'       original true                       #
zstyle ':completion:*:default'         list-colors ${(s.:.)LS_COLORS}      # activate color-completion(!)
zstyle ':completion:*:descriptions'    format $'%{\e[0;31m%}completing %B%d%b%{\e[0m%}'  # format on completion
zstyle ':completion:*:history-words'   list false                          #
zstyle ':completion:*:history-words'   remove-all-dups yes                 # ignore duplicate entries
zstyle ':completion:*:history-words'   stop yes                            #
zstyle ':completion:*'                 matcher-list 'm:{a-z}={A-Z}'        # match uppercase from lowercase
zstyle ':completion:*:matches'         group 'yes'                         # separate matches into groups
zstyle ':completion:*'                 group-name ''
zstyle ':completion:*:messages'        format '%d'                         #
zstyle ':completion:*:options'         auto-description '%d'               #
zstyle ':completion:*:options'         description 'yes'                   # describe options in full
zstyle ':completion:*:processes'       command 'ps -au$USER'               # on processes completion complete all user processes
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters        # offer indexes before parameters in subscripts
zstyle ':completion:*'                 verbose true                        # provide verbose completion information
zstyle ':completion:*'                 menu select
zstyle ':completion:*:warnings'        format $'%{\e[0;31m%}No matches for:%{\e[0m%} %d' # set format for warnings
zstyle ':completion:*:*:zcompile:*'    ignored-patterns '(*~|*.zwc)'       # define files to ignore for zcompile
zstyle ':completion:correct:'          prompt 'correct to: %e'             #
zstyle ':completion:*:functions'       ignored-patterns '_*'               # Ignore completion functions for commands you don't have:
zstyle ':completion:*'                 special-dirs true                   # Complete also special dirs as ..

# complete manual by their section
zstyle ':completion:*:manuals'    separate-sections true
zstyle ':completion:*:manuals.*'  insert-sections   true



# Completion caching
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zcache
zstyle ':completion:*:cd:*' ignore-parents parent pwd

zstyle ':completion::complete:cd::' tag-order local-directories
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*:kill:*'   force-list always
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

# Do not complete remote branch names for git on checkout, they can not be checked out without a remote prefix
zstyle ':completion::complete:git-checkout:argument-rest:remote-branch-refs-noprefix' command ''
zstyle ':completion:*:*' ignored-patterns '*ORIG_HEAD' '*FETCH_HEAD'
zstyle ':completion:*:git-checkout:*' ignored-patterns '*HEAD'

CDPATH=.:~:~/git

#I want my umask 0002 if I'm not root
if [[ $(whoami) = root ]]; then
  umask 0022
else
  umask 0002
fi

#aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias ll='ls -lh'
alias la='ls -lAh'
alias less='less --follow-name'
alias info="info --vi-keys"
alias sqlite3='sqlite3 --header --column'
alias dd='dd status=progress'

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

show-colors() {
  for line in {0..17}; do
    for col in {0..15}; do
      code=$(( $col * 18 + $line ));
      printf $'\e[38;05;%dm %03d' $code $code;
    done;
    echo;
  done
}

#allow tab completion in the middle of a word
setopt COMPLETE_IN_WORD
setopt CORRECT

## keep background processes at full speed
#setopt NOBGNICE
## restart running processes on exit
#setopt HUP

## history
setopt APPEND_HISTORY
## for sharing history between zsh processes
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
## ignore duplicate commands in history
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE

## dirstack
setopt AUTO_PUSHD

## show menu on completion
unsetopt MENUCOMPLETE
setopt AUTOLIST AUTOMENU

## activate extended globbing
setopt EXTENDEDGLOB
## report status of background tasks immediately
setopt NOTIFY

## never ever beep ever
setopt NO_BEEP

## Extend parameters automattically
setopt AUTO_PARAM_KEYS
setopt AUTO_PARAM_SLASH

## disable flow-cotnrol so C-s is working for forward search again
#setopt NOFLOWCONTROL

unsetopt NOMATCH            # do not print error on non matched patterns
## automatically decide when to page a list of completions
#LISTMAX=0

## Allow Ctrl-S for forward-search.
setopt NOFLOWCONTROL

## disable mail checking
#MAILCHECK=0

autoload -U colors && colors
# set some colors

setopt PROMPT_SUBST

if [[ -f ~/.dir_colors ]] ; then
  eval $(dircolors -b ~/.dir_colors)
elif [[ -f /etc/DIR_COLORS ]] ; then
  eval $(dircolors -b /etc/DIR_COLORS)
fi

case $TERM in
    xterm*)
        precmd () {print -Pn "\e]0;%n@%m: %~\a"}
        ;;
esac

powerline-daemon -q
source /usr/share/powerline/bindings/zsh/powerline.zsh
