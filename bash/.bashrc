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
alias goodnight='sudo shutdown now'
alias noice='echo I know right!'
alias wot='echo wot in ternation'
alias fuck='echo -e "Well, \e[3msorrryy\e[0m. ERROR: Problem exists between chair and keyboard."'
alias macho='man'
alias bootstat='chromium $(cp <(systemd-analyze plot) /tmp/disp.svg && echo /tmp/disp.svg)'
alias kernbootstat='dmesg -td | sort'
alias copydir='pwd | xclip -selection c'
bepis () {
	replace="bepis"
	man $1 | sed -e "s/$1/$replace/ig" | less
}
alias neofetch='neofetch --ascii_colors 2 --ascii /usr/share/neofetch/ascii/games/aperture'
alias urxvt='urxvt -pixmap "/home/duncan/.backgrounds/Blur.png;style=root-tiled"'
alias homevpn='cd /home/duncan/Projects/Home/VPNSANDSTUFF/personal_accounts/Duncan/ && sudo openvpn client.ovpn'

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
#man() {
#  /usr/bin/man $* | \
	#    col -b | \
	#    vim -R -c 'set ft=man nomod nolist' -
#}

# Use .inputrc (Use CTRL+Arrow to move over words)
export INPUTRC=~/.inputrc
export EDITOR="nvim"

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
	. /usr/share/bash-completion/bash_completion

# Promptline.vim compat
#source ~/.shell_prompt.sh

# Wtf go whyyyy
export GOPATH=$HOME/.go
export PATH=$PATH:~/.cargo/bin

# RUST!
export RUST_SRC_PATH=~/.multirust/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src


#echo -e -n "\x1b[\x36 q" # changes to steady bar
#export PS1='\e[0;33m \w \e[0m> '
GREEN="\[$(tput setaf 2)\]"
RESET="\[$(tput sgr0)\]"
export PS1="${GREEN} \w ${RESET}> "
