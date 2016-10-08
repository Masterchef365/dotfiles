#!/bin/bash
function runcmd () {
	case "$1" in
	[0-9]|10 )
		i3-msg "workspace "$1
		echo $1
			;;
		"net" )
		connman-gtk --no-icon
			;;
		"term" )
		urxvt
			;;
		"calender" )
		google-chrome-stable 'https://calendar.google.com/calendar/render#main_7%7Cmonth' & #& makes it run in another job so it doesn't stall the other buttons
			;;	
		"" )
			;;		
	esac
}

export -f runcmd

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

mono $DIR/TopBar.exe | lemonbar -f "Fantasque Sans Mono:bold" | xargs -I {} bash -c 'runcmd "$@"' _ {}


