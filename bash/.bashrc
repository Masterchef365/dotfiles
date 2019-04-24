# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Prompt
export PROMPT_DIRTRIM=2  
export PS1="\[\e[93m\] \w \[\e[97m\]> "

# Use .inputrc
export INPUTRC=~/.inputrc

# Use the best editor
export EDITOR='nvim'
alias vim=$EDITOR
alias emacs=$EDITOR

# Vi style line editing
set -o vi

# Aliases
alias ls='ls --color=auto'
alias la='ls -a'
alias ll='ls -lh'
alias tree='tree -C'

# Bad habits
alias q='exit'
function cd () {
	command cd "$@" && ls
}
alias cd..='cd ..'
alias pacman='sudo pacman'
alias advice="echo Don\'t panic!"

# Directory pinning
PIN_DIR=$HOME/.pins
d() {
	case "$1" in 
		"") xargs -a "$PIN_DIR" basename -a | cat -n ;;
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
export LD_LIBRARY_PATH=/usr/lib:$LD_LIBRARY_PATH

# Find largest directories at current working dir
dus() {
    du -shc * | sort -h
}

# Quick interface bridging
bridge() {
	sudo sysctl net.ipv4.ip_forward=1
	sudo iptables -t nat -A POSTROUTING -o $1 -j MASQUERADE
	sudo iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
	sudo iptables -A FORWARD -i $2 -o $1 -j ACCEPT
}

# Quickly uninstall several packages at once in Arch Linux
bulk_uninstall() {
	comm -13 <(pacaur -Qqg base base-devel | sort) <(pacaur -Qqet | sort) > /tmp/installed
	cp /tmp/installed /tmp/remaining	
	$EDITOR /tmp/remaining
	comm -13 /tmp/remaining /tmp/installed | pacaur -Rns -
    rm /tmp/installed /tmp/remaining
}

# Power saving stuff
powersave() {
	sudo sh -c 'echo 1 >> /sys/devices/system/cpu/intel_pstate/no_turbo'
	sudo cpupower frequency-set -u 800Mhz
}

# Text file to PDF
txt2pdf() {
    #enscript $1 -Be'%' -p - | ps2pdf - $(basename -s .txt $1).pdf
    enscript $1 -Bp - | ps2pdf - $(basename -s .txt $1).pdf
}

# Print pdf to an arbitrary printer using JetDirect
# Can be used to circumvent an on-campus pay-to-print system, provided
# you can get the IP of the printer (often, they have a 'print config' option)
printto() {
    pdf2ps "$1" - | nc "$2" 9100
}

# Remove orphaned packages
remove_orphans() {
    pacaur -Rns $(pacaur -Qtdq)
}

# Python lint stuffs
python_lints() {
    pytest
    pycodestyle --show-source --show-pep8 --statistics --max-line-length=100 !(test*).py
    pydocstyle !(test*).py
    pylint !(test*).py
}
