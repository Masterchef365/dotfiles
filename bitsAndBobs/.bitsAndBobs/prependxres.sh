#!/bin/bash
cat <(sh process_resources.sh) <(echo) <(sed $1 -e 's/^#define/!#define/g') > /tmp/tempxres 
wait
cp /tmp/tempxres $1
rm /tmp/tempxres
xrdb $1
i3-msg reload
killall lemonbar
killall bar.sh
cd ~/.lemonbar
sh executebar.sh &
oomox-cli -o theme xresources_oomox
