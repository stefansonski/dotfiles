export GIT_PS1_SHOWUPSTREAM="auto verbose git svn"
export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWCOLORHINTS=true

PROMPT_COMMAND="__git_ps1 '\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]' '\\$ ' ':[%s]' "
