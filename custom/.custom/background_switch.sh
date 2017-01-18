#!/bin/bash
filename=$(basename "$1")
background_dir="/usr/share/backgrounds"
sudo convert $1 -resize '2880x1800^' -gravity center -crop 2880x1800+0+0 +repage $background_dir/current/current.jpg
sudo cp $background_dir/current/current.jpg $background_dir/${filename%*.}.jpg 
sudo convert -blur 0x51 $background_dir/current/current.jpg $background_dir/current/current_blur.jpg
feh --bg-fill $background_dir/current/current.jpg
