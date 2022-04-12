# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Prompt
export PROMPT_DIRTRIM=2  
export PS1="\[\e[93m\] \w \[\e[39m\]"

# Use .inputrc
export INPUTRC=~/.inputrc

# Use a big history file. I don't want to have to remember!
export HISTFILESIZE=25000

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
alias mv='mv -i'

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

# Clipboard
alias xc='xclip -selection c'

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
	. /usr/share/bash-completion/bash_completion

# Rust paths
source ~/.cargo/env

# Cuda path
export PATH=$PATH:/usr/local/cuda-10.0/bin/

# Go path
export GOPATH=$HOME/.go

# Source package paths
export PATH=$PATH:/home/duncan/source_packages
export PATH=$PATH:$HOME/Projects/geoprofile/tools/target/release/

# Use terminal for GPG pin entry
export GPG_TTY=$(tty)
export PINENTRY_USER_DATA="USE_CURSES=1"

# Fuck you, microsoft
export DOTNET_CLI_TELEMETRY_OPTOUT=1

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

# https://unix.stackexchange.com/questions/291282/have-tree-hide-gitignored-files
tree-git-ignore() {
    local ignored=$(git ls-files -ci --others --directory --exclude-standard)
    local ignored_filter=$(echo "$ignored" \
                    | egrep -v "^#.*$|^[[:space:]]*$" \
                    | sed 's~^/~~' \
                    | sed 's~/$~~' \
                    | tr "\\n" "|")
    tree --prune -I ".git|${ignored_filter: : -1}" "$@"
}

boardnas() {
    cd $(echo "$1" | sed -e 's:\\:/:g' -e 's:boardnas/Packages:/media/boardnas:')
}

god() {
    echo "sorry bud"
}

clip() {
    xclip -selection c $@
}

update_ra() {
    curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.local/bin/rust-analyzer
    chmod +x ~/.local/bin/rust-analyzer
}

start_conda() {
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/home/duncan/.anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/home/duncan/.anaconda3/etc/profile.d/conda.sh" ]; then
            . "/home/duncan/.anaconda3/etc/profile.d/conda.sh"
        else
            export PATH="/home/duncan/.anaconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<
}

count_mut() {
    bc -l <<< "$(rg 'let mut ' | wc -l) / $(rg 'let ' | wc -l)"
}

free_port() {
    fuser -k $1
}

cfc() {
    cargo fmt && git commit $@
}

export LD_LIBRARY_PATH=$HOME/source_packages/vulkan_sdk/x86_64/lib
export VK_LAYER_PATH=$HOME/source_packages/vulkan_sdk/x86_64/etc/vulkan/explicit_layer.d
export PATH=$PATH:$HOME/source_packages/vulkan_sdk/x86_64/bin/
