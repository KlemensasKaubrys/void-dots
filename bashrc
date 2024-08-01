# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
export PATH="/home/clemens/dwmblocks/blocks:$PATH"
export PATH="/home/clemens/.scripts:$PATH"
