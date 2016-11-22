#!/bin/bash
colornumber=8
cd ./acyl
./icon.sh "$(grep "*color"$colornumber /home/$USER/.Xresources | awk '{print $2}')"
