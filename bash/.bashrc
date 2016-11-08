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
alias vim='nvim'
alias v='nvim -S vimsession.vim'
function cs () {
	cd "$@" && ls
}
alias cd='cs'
alias rs='reset'
alias tty-clock='tty-clock -C 6'

# Use .inputrc (Use CTRL+Arrow to move over words)
export INPUTRC=~/.inputrc

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
	. /usr/share/bash-completion/bash_completion

# Terminal Title (Only if we have sufficient width)
tput setaf 10
if (( $(tput cols) > 114 )); then 
sed "s/\([a-Z]\)/\1 /g" < /etc/hostname | figlet -tf 3-d
echo 
echo
fi

# Promptline.vim compat
source ~/.shell_prompt.sh

# Wtf go whyyyy
export GOPATH=$HOME/.go

