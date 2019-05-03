export PATH=$HOME/bin:/usr/local/bin:$PATH

[ -z "$PS1" ] && return

export EDITOR=vim

alias l='ls -aCF'
alias ll='ls -alF'
alias lt='ls -alt'
alias v=vim

. /etc/bash_completion

TRST="\[$(tput sgr0)\]"
TTS="\[\033[38;5;7m\]"
TUSER="\[\033[38;5;3m\]"
TSEP="\[\033[38;5;8m\]"
THOST="\[\033[38;5;2m\]"
TPWD="\[\033[38;5;6m\]"
TPS="\[\033[38;5;11m\]"
GITPS="$TTS"'$(__git_ps1 "⎇ %s")'

PS1="$TTS\t $TUSER$USER$TSEP@$THOST\h$TSEP:$TPWD\w$GITPS\n$TPS\\$ $TRST"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
