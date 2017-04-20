#!/bin/bash
pacman -Qkk 2>/dev/null | grep "Modification" | sed -n 's:.*\(/etc/.*\)\s*(.*:\1:p'
