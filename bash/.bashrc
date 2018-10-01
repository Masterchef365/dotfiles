# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Use the best editor
export EDITOR="nvim"

# Use .inputrc
export INPUTRC=~/.inputrc

# Better line editing
set -o vi

# Prompt
GREEN="\[$(tput setaf 1)\]"
RESET="\[$(tput sgr0)\]"
export PROMPT_DIRTRIM=2
export PS1="${GREEN} \w ${RESET}> "

# Bad habits
alias ls='ls --color=auto'
alias la='ls -a --color=auto'
alias ll='ls -lh'
alias cd..='cd ..'
alias cd...='cd ..'
alias dus='du -shc * | sort -h'
alias vim='nvim'
alias v='vim -S vimsession.vim'
function cd () {
	command cd "$@" && ls
}
alias ':wqa'='exit'
alias 'q'='exit'
alias pacman="sudo pacman"
alias thinkofthe='pacaur -Rns $(pacaur -Qtdq)'


# Directory pinning
PIN_DIR=$HOME/.pins
d() {
	case "$1" in 
		"")
            basename -a $(cat "$PIN_DIR") | cat -n ;;
		[0-9]*)
			cd $(sed "$1q;d" "$PIN_DIR") ;;
		"del")
			sed -i "$2d" "$PIN_DIR" ;;
		"e")
			$EDITOR "$PIN_DIR" ;;
		"p")
			pwd >> $PIN_DIR ;;
		*)
			echo "$@" >> $PIN_DIR ;;
	esac
}

# Colored manual pages
man() {
	LESS_TERMCAP_md=$'\e[01;31m' \
	LESS_TERMCAP_me=$'\e[0m' \
	LESS_TERMCAP_se=$'\e[0m' \
	LESS_TERMCAP_so=$'\e[01;44;33m' \
	LESS_TERMCAP_ue=$'\e[0m' \
	LESS_TERMCAP_us=$'\e[01;32m' \
	command man "$@"
}

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
	. /usr/share/bash-completion/bash_completion

# Rust paths
export PATH=$PATH:~/.cargo/bin
export RUST_SRC_PATH=~/.multirust/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src
export LD_LIBRARY_PATH=$(rustc --print sysroot)/lib:$LD_LIBRARY_PATH

# Quick interface bridging
bridge() {
	sudo sysctl net.ipv4.ip_forward=1
	sudo iptables -t nat -A POSTROUTING -o $1 -j MASQUERADE
	sudo iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
	sudo iptables -A FORWARD -i $2 -o $1 -j ACCEPT
}

# Quickly uninstall many packages in Arch Linux
bulkuninstall() {
	comm -13 <(pacaur -Qqg base base-devel | sort) <(pacaur -Qqet | sort) > /tmp/installed
	cp /tmp/installed /tmp/remaining	
	$EDITOR /tmp/remaining
	comm -13 /tmp/remaining /tmp/installed | pacaur -Rns -
}
