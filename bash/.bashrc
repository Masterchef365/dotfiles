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
alias 'll'='ls -lh'
alias cd..='cd ..'
alias cd...='cd ..'
alias vim='nvim'
alias v='nvim -S vimsession.vim'
function cs () {
	cd "$@" && ls
}
alias cd='cs'
alias rs='tput reset'
alias ran='ranger'
function cdf () {
       tmpfile="/tmp/where"
       ranger --choosedir="$tmpfile"
       cd $(cat "$tmpfile")
       rm $tmpfile
}

#Useful stuff
alias thinkofthe='pacaur -Rns $(pacaur -Qtdq)'
alias tty-clock='tty-clock -C 6'
alias copydir='pwd | xclip -selection c'
alias goodnight='sudo shutdown now'
alias bootstat='chromium $(cp <(systemd-analyze plot) /tmp/disp.svg && echo /tmp/disp.svg)'
alias kernbootstat='dmesg -td | sort'
alias weather='curl wttr.in'
alias ds='for x in *; do du -sh "$x"; done'
function swap()         
{
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE && mv "$2" "$1" && mv $TMPFILE $2
}

# Project management stuff
alias projdesc='for x in */; do echo "$x : $(cat $x/.desc 2>/dev/null)"; done | column -t -s ":"'

# Jokes
alias noice='echo I know right!'
alias wot='echo wot in ternation'
alias fuck='echo -e "Well, \e[3msorrryy\e[0m. ERROR: Problem exists between chair and keyboard."'
alias macho='man'
bepis () {
	replace="bepis"
	man $1 | sed -e "s/$1/$replace/ig" | less
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

# Wtf go whyyyy
export GOPATH=$HOME/.go

# RUST!
export PATH=$PATH:~/.cargo/bin
export RUST_SRC_PATH=~/.multirust/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src

# Simple prompt
GREEN="\[$(tput setaf 2)\]"
RESET="\[$(tput sgr0)\]"
export PS1="${GREEN} \w ${RESET}> "
