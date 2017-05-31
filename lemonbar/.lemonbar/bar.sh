#!/bin/bash

# Copy to dedodated wam for speed
cp $1 /tmp/.Xresources

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
text_bg=$(GetColor "S_color15")
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
				#HighlightFG $highlight_main
			fi

			if [[ $last_was_focused == "false" && $focused == "false" ]]; then
				HighlightFG $highlight_main
				#echo -n $divider_left
			fi

			if [[ $last_was_focused == "false" && $focused == "true" ]]; then
				HighlightBG $highlight_main
				#echo -n $seperator_left
				#HighlightBG $highlight_main
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
	cat /tmp/battery
	Pad
	HighlightFG $highlight_main
}

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
	mpc current | sed -e 's/\(.*\)\..*$/\1/g' |  tr -d '\n\r'
	Pad
	HighlightFG $highlight_main
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

TMUX_Integration () {
	for x in $(tmux list-sessions 2>/dev/null | awk '{print $1}' | tr -d ':'); do 
		HighlightBG $highlight_sub3
		SmallPad
		echo -n $x
		SmallPad
		HighlightFG $highlight_main
		SmallPad
	done		
}

Check_Calendar () {
	HighlightBG $highlight_main
	SmallPad
	cat /tmp/calendar
	SmallPad
	HighlightFG $highlight_main
}

Left() {
	echo -n "%{l}"
	WMIntegration
}

Center() {
	echo -n "%{c}"
	}

Right() {
	echo -n "%{r}"
	TMUX_Integration
	SmallPad
	Clock
	SmallPad
	MPD_Integration
	SmallPad
	Check_Calendar
	SmallPad
	Reddit
	SmallPad
	Email
	SmallPad
	Wifi
	SmallPad
	Battery
}

Check_Battery_Loop () {
	while true; do
		value=$(acpi | awk '{print $3$4$5}' | tr ',' ' ' | tr -d '\n\r')
		echo -n $value > /tmp/battery
		sleep 3
	done
}

Check_Mail_Loop () {
	source ~/.private.sh
	while true; do
		curl -u $username@gmail.com:$password --silent "https://mail.google.com/mail/feed/atom" | 
		xmllint --format - | 
		grep "<entry>" | 
		wc -l | 
		tr -d '\r\n' > /tmp/mailtemp.tmp
		sleep 50
	done
}

Check_Reddit_Loop () {
	source ~/.private.sh
	while true; do
		access_token=`curl -s -X POST -d \
			"grant_type=password&username=$reddit_username&password=$reddit_password" \
			--user "$reddit_bot_client_id:$reddit_bot_secret" \
			https://www.reddit.com/api/v1/access_token -A "$reddit_bot_name" | jq -r '.access_token'`
		for x in {0..30}; do
			curl -s -H \
				"Authorization: bearer $access_token" -A \
				"$reddit_bot_name" https://oauth.reddit.com/api/v1/me | 
			jq -r '.inbox_count' |
			tr -d '\r\n' > /tmp/reddit_messages.tmp
			sleep 50
		done
	done
}

Check_Calendar_Loop () {
	while true; do
		value=$(gcalcli agenda --tsv -w 0 | sed -r "s:.*\t$(date +%G)-(.*)\t.*\t(.*):\1\: \2:g" | tr '\r\n' ' ')
		echo -n $value > /tmp/calendar
		sleep 50
	done
}

Check_Calendar_Loop &
Check_Battery_Loop &
Check_Mail_Loop &
Check_Reddit_Loop &

Redraw () {
	Left
	cat /tmp/cached.bar
	#echo
}

Redraw_Loop () {
	while true; do
		echo $(Center)$(Right) > /tmp/cached.bar
		Redraw
		sleep 3
	done
}

if [[ -f /bin/jq ]]; then
	Redraw_Loop &
	./event.pl workspace |
	while read -r x; do
		Redraw
	done
else
	echo "Bar requires jq to run!"
fi

