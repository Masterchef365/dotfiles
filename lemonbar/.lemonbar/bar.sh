#!/bin/bash

# Copy to dedodated wam for speed
cp ~/.Xresources /tmp/.Xresources

# Get color by name. TODO: Use a better way lol
GetColor() {
	grep "\*$1\:" /tmp/.Xresources | awk '{print $2}'
}

# Set frequently used colors
main_bg=$(GetColor "background")
main_fg=$(GetColor "foreground")
highlight=$(GetColor "color10")

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
	echo -n $(GetBGLemonColor $highlight)
	echo -n $(GetFGLemonColor $main_bg)
}

HighlightFG() {
	echo -n $(GetFGLemonColor $highlight)
	echo -n $(GetBGLemonColor $main_bg)
}

WMIntegration() {
	HighlightBG
	first="true"
	last_was_focused="false"
	for i in $(i3-msg -t get_workspaces | jq -s -c '.[] | .[] | {focused: .focused, number: .num}'); do
		focused=$(echo $i | jq '.focused')
		number=$(echo $i | jq '.number')

		if [[ $first != "true" ]]; then
			if [[ $last_was_focused == "true" && $focused == "false" ]]; then
				HighlightBG
				echo -n $seperator_left
				HighlightBG
			fi

			if [[ $last_was_focused == "false" && $focused == "false" ]]; then
				HighlightBG
				echo -n $divider_left
			fi

			if [[ $last_was_focused == "false" && $focused == "true" ]]; then
				HighlightFG
				echo -n $seperator_left
				HighlightFG
			fi

		else 
			if [[ $focused == "true" ]]; then
				HighlightFG
			else
				HighlightBG
			fi
		fi

		echo -n " $number "

		first="false"
		last_was_focused=$focused
	done

	if [[ $last_was_focused == "false" ]]; then
		HighlightBG
		echo -n %{R}$seperator_left 
	fi
	HighlightFG	
}

Clock() {
	date "+%a %D %H:%M" | tr '\n\r' ' '
}

Left() {
	echo -n "%{l}"
	WMIntegration
}

Center() {
	echo -n "%{c}"
	Clock
}
#
#Right(){
#}



while true; do
	if [[ -f /bin/jq ]]; then
		echo
		Left
		Center
	else
		echo "Bar requires jq to run!"
	fi
	sleep 1
done

# TODO Add for each monitor that's connected the same thing
