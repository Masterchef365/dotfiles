# If not running interactively, don't do anything
[[ $- != *i* ]] && return

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

# Use the best editor /s
export EDITOR="nvim"

# Behold the unholy heap of bad habits
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
function mkcd () {
	mkdir $@ && cd "$1"
}
alias ':wqa'='exit'
alias 'q'='exit'
function cl () {
	clear
	cal
	calcurse -t
	echo
	calcurse -d7
}

#Useful stuff
alias thinkofthe='pacaur -Rns $(pacaur -Qtdq)'
alias weather='curl wttr.in'
alias neofetch='neofetch --ascii_colors 2 --ascii /usr/share/neofetch/ascii/games/aperture'
function numpy() {
	python -ic 'import numpy as np'
}

# Command pinning, todo list, etc.
PIN_DIR=$HOME/.pins
d() {
	case "$1" in 
		[0-9]*)
			line=$(sed "$1q;d" "$PIN_DIR") 
			if [ -d "$line" ] && [ ! -f "$line" ]; then
				cd "$line"
			else
				command $line
			fi ;;
		"del")
			sed -i "$2d" "$PIN_DIR" ;;
		"e")
			$EDITOR "$PIN_DIR" ;;
		"p")
			pwd >> $PIN_DIR ;;
		"")
			while read -r line; do
				if [ -d "$line" ] && [ ! -f "$line" ]; then
					basename -a "$line"
				else
					echo "$line"
				fi
			done < "$PIN_DIR" | cat -n 
			;;
		*)
			echo "$@" >> $PIN_DIR ;;
	esac
}

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

ecc() {
	gcc -o $1 $1.c && ./$@
}

# Use .inputrc (Use CTRL+Arrow to move over words)
export INPUTRC=~/.inputrc


# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
	. /usr/share/bash-completion/bash_completion

# RUST!
export PATH=$PATH:~/.cargo/bin
export RUST_SRC_PATH=~/.multirust/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src
export LD_LIBRARY_PATH=$(rustc --print sysroot)/lib:$LD_LIBRARY_PATH

# Simple, clean prompt editing options
GREEN="\[$(tput setaf 2)\]"
RESET="\[$(tput sgr0)\]"

export PROMPT_DIRTRIM=2
export PS1="${GREEN} \w ${RESET}> "
set -o vi
