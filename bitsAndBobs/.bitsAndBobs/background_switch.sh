#!/bin/bash
sudo convert $1 -monitor -blur 0x51 -resize '2880x1800^' -gravity center -crop 2880x1800+0+0 +repage /usr/share/backgrounds/lightdm/background.jpg
feh --bg-fill $1
