# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Prompt
export PROMPT_DIRTRIM=2  
export PS1="\[\e[93m\] \w \[\e[39m\]"

# Use .inputrc
export INPUTRC=~/.inputrc

# Use the best editor
export EDITOR='nvim'
alias vim=$EDITOR
alias emacs=$EDITOR

# Vi style line editing
if [ ! -n "$VIMRUNTIME" ]; then
    set -o vi
fi

# Aliases
alias ls='ls --color=auto'
alias la='ls -a'
alias ll='ls -lh'
alias tree='tree -C'
alias cd..='cd ..'
alias mv='mv -i' # Let's not learn this the hard way

# Bad habits
function cd () {
	command cd "$@" && ls
}

# Directory pinning
PIN_DIR=$HOME/.pins
d() {
	case "$1" in 
		"") xargs -a "$PIN_DIR" basename -a | cat -n ;;
		"e") sed "$2q;d" "$PIN_DIR" ;;
		[0-9]*) cd $(d e $1) ;;
		"del") sed -i "$2d" "$PIN_DIR" ;;
		"p") pwd >> $PIN_DIR ;;
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

# Pacman
alias pacman='sudo pacman'
# The FuTuRe
alias pacaur='yay'

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
	. /usr/share/bash-completion/bash_completion

# Rust paths
if [[ -f ~/.cargo/env ]]; then
	source ~/.cargo/env
fi

# Python startup script
export PYTHONSTARTUP="$HOME/.config/pythonrc.py"

# Use terminal for GPG pin entry
export GPG_TTY=$(tty)
export PINENTRY_USER_DATA="USE_CURSES=1"

export PATH=$PATH:/home/duncan/.local/bin

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
	#sudo sh -c 'echo 1 >> /sys/devices/system/cpu/intel_pstate/no_turbo'
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

no_dpms() {
    xset -dpms
}

git-shortlog() {
    git log --branches=* --graph --pretty=oneline --abbrev-commit
}

count-src() {
    find src/ -type f -exec wc -l {} + | sort -h
}

git-clean() {
    # git gc --aggressive --prune # Linus says no https://gcc.gnu.org/legacy-ml/gcc/2007-12/msg00165.html
    git repack -a -d --depth=250 --window=250
}

clipcount() {
    xclip -selection c -o | wc -w
}

mp42gif() {
    ffmpeg -i $1 -vf "split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 $(basename -s .mp4 $1).gif
}

http() {
    python -m http.server
}

update_ra() {
    pacman -S rust-analyzer
    #curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.local/bin/rust-analyzer
    #chmod +x ~/.local/bin/rust-analyzer
}

backup() {
    rsync -av --info=progress2 ~/Projects /media/extdisk/ $@
    rsync -av --info=progress2 ~/Media /media/extdisk/ $@
    rsync -av --info=progress2 ~/Notes /media/extdisk/ $@
}

theme() {
    xrdb ~/.Xresources
    i3-msg restart
}

clip() {
    xclip -selection c $@
}

#export LD_LIBRARY_PATH=$HOME/source_packages/1.2.141.2/x86_64/lib
#export VK_LAYER_PATH=$HOME/source_packages/1.2.141.2/x86_64/etc/vulkan/explicit_layer.d
export PATH=$PATH:$HOME/source_packages/
#source $HOME/source_packages/1.2.141.2/setup-env.sh
vk_setup="$HOME/source_packages/1.2.182.0/setup-env.sh"
if [[ -f $vk_setup ]]; then
    source $vk_setup
fi

export HISTSIZE=100000
export HISTFILESIZE=100000
. "$HOME/.cargo/env"
