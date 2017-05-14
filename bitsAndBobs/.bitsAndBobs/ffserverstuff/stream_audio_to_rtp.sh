#!/bin/bash
#ffmpeg -re -f pulse -i default -acodec libmp3lame -f rtp rtp://192.168.1.22:1234
ffmpeg -re -f pulse -i default -acodec libmp3lame -f rtp rtp://192.168.1.64:1234
