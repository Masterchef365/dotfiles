#!/bin/bash

# Copy to dedodated wam for speed
cp ~/.Xresources /tmp/.Xresources

Pad () {
	echo -n "  "
}

SmallPad () {
	echo -n " "
}

# Get color by name. TODO: Use a better way lol
GetColor() {
	grep "\#define $1\s." /tmp/.Xresources | awk '{print $3}'
}
# Set frequently used colors
main_bg=$(GetColor "S_background")
main_fg=$(GetColor "S_foreground")
highlight_main=$(GetColor "S_color10")
highlight_sub=$(GetColor "S_color9")
highlight_sub2=$(GetColor "S_color12")
highlight_sub3=$(GetColor "S_color14")

seperator_left=""
seperator_right=""
divider_left=""
divider_right=""

GetFGLemonColor() {
	echo %{F$1}
}

GetBGLemonColor() {
	echo %{B$1}
}

HighlightBG() {
	echo -n $(GetBGLemonColor $1)
	echo -n $(GetFGLemonColor $main_bg)
}

HighlightFG() {
	echo -n $(GetFGLemonColor $1)
	echo -n $(GetBGLemonColor $main_bg)
}

WMIntegration() {
	HighlightBG $highlight_main
	first="true"
	last_was_focused="false"
	for i in $(i3-msg -t get_workspaces | jq -s -c '.[] | .[] | {focused: .focused, number: .num}'); do
		focused=$(echo $i | jq '.focused')
		number=$(echo $i | jq '.number')

		if [[ $first != "true" ]]; then
			if [[ $last_was_focused == "true" && $focused == "false" ]]; then
				HighlightFG $highlight_main 
				#echo -n $seperator_left
				HighlightFG $highlight_main
			fi

			if [[ $last_was_focused == "false" && $focused == "false" ]]; then
				HighlightFG $highlight_main
				#echo -n $divider_left
			fi

			if [[ $last_was_focused == "false" && $focused == "true" ]]; then
				HighlightBG $highlight_main
				#echo -n $seperator_left
				HighlightBG $highlight_main
			fi

		else 
			if [[ $focused == "true" ]]; then
				HighlightBG $highlight_main
			else
				HighlightFG $highlight_main
			fi
		fi

		echo -n " $number "

		first="false"
		last_was_focused=$focused
	done

	if [[ $last_was_focused == "false" ]]; then
		HighlightBG $highlight_main
		#echo -n %{R}$seperator_left 
	fi
	HighlightFG	$highlight_main
}

Clock() {
	HighlightBG $highlight_main
	Pad
	date "+%a %D %H:%M" | tr -d '\n\r'
	Pad
	HighlightFG $highlight_main
}

Battery() {
	HighlightBG $highlight_main
	Pad
	acpi | awk '{print $3$4$5}' | tr ',' ' ' | tr -d '\n\r'
	Pad
	HighlightFG $highlight_main
}

./check_mail_loop.sh &
Email () {
	if grep -q 0 "/tmp/mailtemp.tmp"; then
		HighlightBG $highlight_sub3
	else 
		HighlightBG $highlight_sub2
	fi
	Pad
	echo -n ""
	Pad
	cat /tmp/mailtemp.tmp
	Pad

	HighlightFG $highlight_main
}

./check_reddit_messages_loop.sh &
Reddit () {
	if grep -q 0 "/tmp/reddit_messages.tmp"; then
		HighlightBG $highlight_sub3
	else 
		HighlightBG $highlight_sub
	fi
	Pad
	echo -n ""
	Pad
	cat /tmp/reddit_messages.tmp
	Pad

	HighlightFG $highlight_main
}

MPD_Integration () {
	HighlightBG $highlight_sub3
	Pad
	echo -n ""
	Pad
	mpc current | tr -d '\n\r'
	Pad
}

Wifi () {
	HighlightBG $highlight_sub3
	Pad
	echo -n ""
	Pad
	iwconfig 2> /dev/null | sed -n 's:.*Link Quality=\([0-9]*\/[0-9]*\).*:\1:p' | tr -d '\r\n'
	Pad
	HighlightFG $highlight_main
}

Left() {
	echo -n "%{l}"
	WMIntegration
}

Center() {
	echo -n "%{c}"
	Clock
}

Right(){
	echo -n "%{r}"
	#MPD_Integration
	Reddit
	SmallPad
	Email
	SmallPad
	Wifi
	SmallPad
	Battery
	SmallPad
}

while true; do
	if [[ -f /bin/jq ]]; then
		Left
		Center
		Right
		echo
	else
		echo "Bar requires jq to run!"
	fi
	sleep 3
done

# TODO Add for each monitor that's connected the same thing
