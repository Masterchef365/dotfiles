#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias la='ls -a --color=auto'
alias pacman="sudo pacman"
alias 'll'='ls -l --block-size=MB'
alias cd..='cd ..'
alias v='vim -S vimsession.vim'
export INPUTRC=~/.inputrc

# Poweline (Depreciated)
# powerline-daemon -q
# POWERLINE_BASH_CONTINUATION=1
# POWERLINE_BASH_SELECT=1
# . /usr/lib/python3.5/site-packages/powerline/bindings/bash/powerline.sh

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
	    . /usr/share/bash-completion/bash_completion

# Terminal Title
figlet $(cat /etc/hostname) 


# Promptline
source /home/duncan/.shell_prompt.sh
