#      ___           ___           ___           ___           ___           ___     
#     /\  \         /\  \         /\  \         /\__\         /\  \         /\  \    
#    /::\  \       /::\  \       /::\  \       /:/  /        /::\  \       /::\  \   
#   /:/\:\  \     /:/\:\  \     /:/\ \  \     /:/__/        /:/\:\  \     /:/\:\  \  
#  /::\~\:\__\   /::\~\:\  \   _\:\~\ \  \   /::\  \ ___   /::\~\:\  \   /:/  \:\  \ 
# /:/\:\ \:|__| /:/\:\ \:\__\ /\ \:\ \ \__\ /:/\:\  /\__\ /:/\:\ \:\__\ /:/__/ \:\__\
# \:\~\:\/:/  / \/__\:\/:/  / \:\ \:\ \/__/ \/__\:\/:/  / \/_|::\/:/  / \:\  \  \/__/
#  \:\ \::/  /       \::/  /   \:\ \:\__\        \::/  /     |:|::/  /   \:\  \      
#   \:\/:/  /        /:/  /     \:\/:/  /        /:/  /      |:|\/__/     \:\  \     
#    \::/__/        /:/  /       \::/  /        /:/  /       |:|  |        \:\__\    
#     ~~            \/__/         \/__/         \/__/         \|__|         \/__/    


# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Behold the unholy heap of bad habits
alias ls='ls --color=auto'
alias la='ls -a --color=auto'
alias pacman="sudo pacman"
alias 'll'='ls -l --block-size=MB'
alias cd..='cd ..'
alias cd...='cd ..'
alias vim='nvim'
alias v='nvim -S vimsession.vim'
function cs () {
	cd "$@" && ls
}
alias cd='cs'
alias rs='tput reset'
alias reset='tput reset'
alias tty-clock='tty-clock -C 6'
alias thinkofthe='pacaur -Rns $(pacaur -Qtdq)'
alias spotify='spotify --force-device-scale-factor=1.5'
alias setbg='. ~/.bitsAndBobs/background_switch.sh' 
alias goodnight='sudo shutdown now'
alias noice='echo I know right!'
alias fuck='echo -e "Well, \e[3msorrryy\e[0m. ERROR: Problem exists between chair and keyboard."'

# Colored man pages
man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

# Use .inputrc (Use CTRL+Arrow to move over words)
export INPUTRC=~/.inputrc
export EDITOR="nvim"

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
	. /usr/share/bash-completion/bash_completion

# Promptline.vim compat
source ~/.shell_prompt.sh

# Wtf go whyyyy
export GOPATH=$HOME/.go

# I-Beam cursor
#echo -en "\033[5 q"
#echo -en "\033[6 q"
#tput reset
