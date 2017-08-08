#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
[[ -z "$TMUX" && -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
