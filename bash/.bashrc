#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

TERM=xterm

#so as not to be disturbed by Ctrl-S ctrl-Q in terminals:
stty -ixon

export VISUAL="vim"
export PS1="[\e[93m\u\e[39m \e[96m\W\e[39m]$\[$(tput sgr0)\] "
