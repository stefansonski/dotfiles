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

source ${${(%):-%N}:A:h}/antigen/antigen.zsh

## use oh-my-zsh as standard repo
antigen use oh-my-zsh

antigen bundle command-not-found
antigen bundle chucknorris

## apply antigen plugins
antigen apply

source /usr/lib/git-core/git-sh-prompt

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
WORDCHARS="${WORDCHARS:s#/#}"
WORDCHARS="${WORDCHARS:s#.#}"
##############################################################
#key binding stuff to get the right keys to work
# key bindings
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[5~" beginning-of-history
bindkey "\e[6~" end-of-history
bindkey "\e[3~" delete-char
bindkey "\e[2~" overwrite-mode
bindkey "\e[5C" forward-word
bindkey "\eOc" emacs-forward-word
bindkey "\e[5D" backward-word
bindkey "\eOd" emacs-backward-word
bindkey "\ee[C" forward-word
bindkey "\ee[D" backward-word
#Ctrl-left/right
bindkey '\e[1;5C' forward-word # ctrl right
bindkey '\e[1;5D' backward-word # ctrl left o
#alt-left/right
bindkey "\e[1;3C" forward-word
bindkey "\e[1;3D" backward-word
#bindkey "^H" backward-delete-word
# for rxvt
bindkey "\e[8~" end-of-line
bindkey "\e[7~" beginning-of-line
# for non RH/Debian xterm, cant hurt for RH/DEbian xterm
bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line
# for freebsd console
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line
# completion in the middle of a line
bindkey '^i' expand-or-complete-prefix

bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/sonski/.zshrc'

autoload -Uz compinit
compinit

# Use gpg completion for gpg2.
# But still the keys from gpg are completed.
compdef gpg2=gpg

# End of lines added by compinstall
## completion system
_force_rehash() {
      (( CURRENT == 1 )) && rehash
          return 1  # Because we didn't really complete anything
}

zstyle ':completion:*' completer _oldlist _expand _force_rehash _complete _approximate
zstyle ':completion:*:approximate:'    max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )' # allow one error for every three characters typed in approximate completer
zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~' # don't complete backup files as executables
zstyle ':completion:*:correct:*'       insert-unambiguous true             # start menu completion only if it could find no unambiguous initial string
zstyle ':completion:*:corrections'     format $'%{\e[0;31m%}%d (errors: %e)%{\e[0m%}' #
zstyle ':completion:*:correct:*'       original true                       #
zstyle ':completion:*:default'         list-colors ${(s.:.)LS_COLORS}      # activate color-completion(!)
zstyle ':completion:*:descriptions'    format $'%{\e[0;31m%}completing %B%d%b%{\e[0m%}'  # format on completion
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select              # complete 'cd -<tab>' with menu
#zstyle ':completion:*:expand:*'        tag-order all-expansions           # insert all expansions for expand completer
zstyle ':completion:*:history-words'   list false                          #
zstyle ':completion:*:history-words'   menu yes                            # activate menu
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
zstyle ':completion:*:warnings'        format $'%{\e[0;31m%}No matches for:%{\e[0m%} %d' # set format for warnings
zstyle ':completion:*:*:zcompile:*'    ignored-patterns '(*~|*.zwc)'       # define files to ignore for zcompile
zstyle ':completion:correct:'          prompt 'correct to: %e'             #
zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*'    # Ignore completion functions for commands you don't have:
zstyle ':completion:*'                 special-dirs true                   # Complete also special dirs as ..

# complete manual by their section
zstyle ':completion:*:manuals'    separate-sections true
zstyle ':completion:*:manuals.*'  insert-sections   true
zstyle ':completion:*:man:*'      menu yes select



# Completion caching
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path .zcache
zstyle ':completion:*:cd:*' ignore-parents parent pwd

zstyle ':completion::complete:cd::' tag-order local-directories
zstyle ':completion:*' menu select=2
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

CDPATH=.:~:~/git
PATH=$PATH:~/bin

#I want my umask 0002 if I'm not root
if [[ $(whoami) = root ]]; then
    umask 0022
else
    umask 0002
fi



#setup ~/.dir_colors if one doesn\'t exist
if [ ! -s ~/.dir_colors ]; then
    dircolors -p > ~/.dir_colors
fi
eval `dircolors ~/.dir_colors`

#aliases
alias g='gvim --remote-silent'
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias  vi=$(which vim)
alias -- -='cd -'
alias  ...='../..'
alias  ....='../../..'
alias  .....='../../../..'
alias  ll='ls -lah'
alias  sl='ls -lah'
alias  l='ls -la'
alias -g X='| xargs'
alias -g G='| egrep'
alias gpg=gpg2
alias sort-log='sort -n -k 1.7,1.10 -k 1.4,1.5 -k 1.1,1.2 -k2,2'

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

## show menu on completion
setopt AUTOLIST AUTO_MENU

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

setopt NOMATCH            # do not print error on non matched patterns
## automatically decide when to page a list of completions
#LISTMAX=0

## disable mail checking
#MAILCHECK=0

autoload -U colors && colors
# set some colors
for COLOR in RED GREEN YELLOW WHITE BLACK CYAN BLUE PURPLE; do
    eval PR_$COLOR='%{$fg[${(L)COLOR}]%}'
    eval PR_BRIGHT_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
done
PR_RESET="%{${reset_color}%}";

setopt prompt_subst

BLUE_DIAMOND="%B%F{blue}◆%f%b"
YELLOW_DIAMOND="%B%F{yellow}◆%f%b"
GREEN_DIAMOND="%B%F{green}◆%f%b"
RED_DIAMOND="%B%F{red}◆%f%b"
RED_RARROW="%B%F{red}▶%f%b"
RED_LARROW="%B%F{red}◀%f%b"
RED_STAR="%B%F{red}✱%b%f"

case $TERM in
    *xterm*|rxvt|(dt|k|E)term)
        preexec () {
            if [[ $(basename ${1[(w)1]}) == "ssh" ]]; then
                SHN=${1[(w)-1]}
                SHN_ARRAY=( ${(s,.,)SHN})
                print -Pn "\e]2;$SHN:%~\a"
            else
                print -Pn "\e]2;%n@%m:%~\a"
            fi
        }
    ;;
    screen)
        preexec () {
            if [[ $(basename ${1[(w)1]}) == "ssh" ]]; then
                SHN=${1[(w)-1]}
                SHN=${SHN#*@}
                SHN_ARRAY=( ${(s,.,)SHN})
                case ${#SHN_ARRAY} in
                    2)
                        print -Pn "\033k$SHN\033\\"
                    ;;
                    4)
                        print -Pn "\033k$SHN_ARRAY[1].$SHN_ARRAY[2]\033\\"
                    ;;
                    5)
                        #print -Pn "\033k$SHN_ARRAY[1].$SHN_ARRAY[2].$SHN_ARRAY[3]\033\\"
                        print -Pn "\033k$SHN_ARRAY[1].$SHN_ARRAY[3]\033\\"
                    ;;
                    *)
                        print -Pn "\033k$SHN_ARRAY[1]\033\\"
                    ;;
                esac
            fi
        }
        #set up precmd to draw the screen title
        function set_screen_title {
            print -Pn "\033k%m\033\\"
        }
        precmd_functions=( set_screen_title )
    ;;
}

if [[ -n $SSH_CONNECTION ]]; then
    SSH_IP=$(echo $SSH_CLIENT | awk '{print $1}')
    HOST_OUTPUT=$(host $SSH_IP)
    if [[ $? -eq 0 ]]; then
        SSH_HOST=$(echo $HOST_OUTPUT | awk '{print $NF}' | sed 's/.$//')
    else
        SSH_HOST=$SSH_IP
    fi
    SSH_PROMPT="${RED_STAR} %F{yellow}SSH from: %f%B%F{green}$SSH_HOST%f%b ${RED_STAR}"
    #SSH_PROMPT="${YELLOW_DIAMOND}${PR_BRIGHT_RED}SSH${PR_RESET}${YELLOW_DIAMOND}"
    #SSH_VAR="${YELLOW_DIAMOND}${PR_BRIGHT_RED}SSH${PR_RESET}${YELLOW_DIAMOND}"

fi

if [[ $(whoami) = root ]]; then
    PROMPT_LINE="%B%F{red}%n@%M%f%b"
else
    PROMPT_LINE="%F{green}%n%f@%B%F{green}%m%b%f${PR_RESET}"
fi

precmd(){
    # Battery Stuff
    if which ibam &> /dev/null; then
        IBAMSTAT="$(ibam)"
        if [[ ${IBAMSTAT[(f)(1)][(w)1]} =  "Battery" ]]; then
            BATTSTATE="$(ibam --percentbattery)"
            BATTPRCNT="${BATTSTATE[(f)1][(w)-2]}"
            BATTTIME="${BATTSTATE[(f)2][(w)-1]}"
            PR_BATTERY="Bat: ${BATTPRCNT}%% (${BATTTIME})"
            if [[ "${BATTPRCNT}" -lt 15 ]]; then
                PR_BATTERY=" ${BLUE_DIAMOND} ${PR_BRIGHT_RED}${PR_BATTERY}"
            elif [[ "${BATTPRCNT}" -lt 50 ]]; then
                PR_BATTERY=" ${BLUE_DIAMOND} ${PR_BRIGHT_YELLOW}${PR_BATTERY}"
            elif [[ "${BATTPRCNT}" -lt 100 ]]; then
                PR_BATTERY=" ${BLUE_DIAMOND} ${PR_BRIGHT_CYAN}${PR_BATTERY}${PR_RESET}"
            else
                PR_BATTERY=""
            fi
        else
            PR_BATTERY=""
        fi
    fi
    ###End of Battery Stuff######

    # now lets change the color of the path if its not writable
    if [[ -w $PWD ]]; then
        PR_PWDCOLOR="%F${PR_BRIGHT_BLUE}"
    else
        PR_PWDCOLOR="${PR_BRIGHT_RED}"
    fi

    # Set git-prompt options for PS1
    export GIT_PS1_SHOWUPSTREAM="auto"
    export GIT_PS1_SHOWCOLORHINTS=true
    export GIT_PS1_SHOWSTASHSTATE=true
    export GIT_PS1_SHOWDIRTYSTATE=true
    export GIT_PS1_SHOWUNTRACKEDFILES=true

    __git_ps1 '${PROMPT_LINE}%B%F${PR_RESET}:%f%b${PR_PWDCOLOR}%~${PR_RESET}' '%(!.%B%F{red}%#%f%b.%B%F{green}➤ %f%b)' ' [%s]'
}

RPROMPT='$SSH_PROMPT ${PR_BATTERY}'

chuck_cow
