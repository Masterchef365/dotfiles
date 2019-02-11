# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Use the best editor
export EDITOR="nvim"
alias vim='nvim'

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
alias la='ls -a'
alias ll='ls -lh'
alias 'q'='exit'
function cd () {
	command cd "$@" && ls
}
alias cd..='cd ..'
alias dus='du -shc * | sort -h'
alias pacman="sudo pacman"

# Directory pinning
PIN_DIR=$HOME/.pins
d() {
	case "$1" in 
		"") basename -a $(cat "$PIN_DIR") | cat -n ;;
		[0-9]*) cd $(sed "$1q;d" "$PIN_DIR") ;;
		"del") sed -i "$2d" "$PIN_DIR" ;;
		"p") pwd >> $PIN_DIR ;;
		*) echo "$@" >> $PIN_DIR ;;
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

# Enable power saving
powersave() {
	sudo sh -c 'echo 1 >> /sys/devices/system/cpu/intel_pstate/no_turbo'
	sudo cpupower frequency-set -u 800Mhz
}

# Text file to PDF
txt2pdf() {
    #enscript $1 -Be'%' -p - | ps2pdf - $(basename -s .txt $1).pdf
    enscript $1 -Bp - | ps2pdf - $(basename -s .txt $1).pdf
}

# Print using JetDirect
printto() {
    pdf2ps "$1" - | nc $2 9100
}

# Remove orphaned packages
remove_orphans() {
    pacaur -Rns $(pacaur -Qtdq)
}

export GOPATH=/home/$USER/.go
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/home/duncan/.gradle/toolchains/frc/2019/roborio/bin
