[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
setxkbmap -option caps:escape
#exec i3
exec gnome-session
