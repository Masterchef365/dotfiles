#!/bin/bash
cat <(sh process_resources.sh) <(echo) <(sed ~/.Xresources -e 's/^#define/!#define/g') > /tmp/tempxres 
wait
cp /tmp/tempxres ~/.Xresources
rm /tmp/tempxres
xrdb ~/.Xresources
i3-msg reload
killall lemonbar
killall bar.sh
cd ~/.lemonbar
sh executebar.sh &
oomox-cli -o theme xresources_oomox
