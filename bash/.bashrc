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
alias rs='tput reset'
alias ls='ls --color=auto'
alias la='ls -a --color=auto'
alias pacman="sudo pacman"
alias 'll'='ls -lh'
alias cd..='cd ..'
alias cd...='cd ..'
alias vim='nvim'
alias v='nvim -S vimsession.vim'
function cd () {
	command cd "$@" && ls
}

#Useful stuff
alias thinkofthe='pacaur -Rns $(pacaur -Qtdq)'
alias weather='curl wttr.in'
alias d='pin'
printpins() {
	count=1
	for pin in $(cat $1); do
		#echo "$count $(basename "$pin") $pin"
		echo "$count $(basename "$pin")"
		(( count++ ))
	done
}
pin() {
	pindir=$HOME/.pins
	case "$1" in 
		"")
			#cat -n "$pindir" ;;
			printpins $pindir ;;
		"p")
			echo "$PWD" >> $pindir ;;
		"del")
			sed -i "$2d" "$pindir" ;;
		"[0-9][0-9]*")
			echo "$1" >> $pindir ;;
		*)
			cd "$(sed "$1q;d" "$pindir")" ;;
	esac
}
alias neofetch='neofetch --ascii_colors 2 --ascii /usr/share/neofetch/ascii/games/aperture'

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
export EDITOR="nvim"

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
	. /usr/share/bash-completion/bash_completion

# RUST!
export PATH=$PATH:~/.cargo/bin
export RUST_SRC_PATH=~/.multirust/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src

# Simple, clean prompt editing options
set -o vi
shopt -s extglob

export INPUTRC=~/.inputrc

GREEN="\[$(tput setaf 2)\]"
RESET="\[$(tput sgr0)\]"

export PROMPT_DIRTRIM=3
export PS1="${GREEN} \w ${RESET}> "

