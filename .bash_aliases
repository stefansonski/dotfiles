alias gpg=gpg2
alias sort-log='sort -n -k 1.7,1.10 -k 1.4,1.5 -k 1.1,1.2 -k2,2'
export GIT_PS1_SHOWUPSTREAM="auto verbose git svn"
export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWCOLORHINTS=true

if [ $VIM ]; then
    PROMT_COMMAND="\u@\h:\w \$ "
else
    PROMPT_COMMAND="__git_ps1 '\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]' '\\$ ' ':[%s]' "
fi
