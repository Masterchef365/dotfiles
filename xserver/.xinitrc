xrdb -merge ~/.Xresources
setxkbmap -option caps:escape
setxkbmap us,apl -option grp:rwin_toggle
xmodmap ~/.Xmodmap
#exec compton
exec i3
