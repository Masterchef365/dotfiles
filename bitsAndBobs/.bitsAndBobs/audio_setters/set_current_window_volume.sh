Get_Window_PID() {
	xprop -id `xdotool getwindowfocus` | grep '_NET_WM_PID' | grep -oE '[[:digit:]]*$'
}

Get_Sink_ID() {
	pacmd list sink inputs | \
	grep -E "index|application.process.id|application.name" | \
	sed -n "1N;2N;/application.process.id = \"$1\"[^\n]*$/P;N;D" | \
	tail -n 1 | \
	sed -e "s/\s*index:\s*\([0-9]*\)/\1/g"
}

Sink_ID=$(Get_Sink_ID $(Get_Window_PID))

if [[ $1 == "VolUp" ]]; then
	if [[ $Sink_ID ]]; then
		pactl set-sink-input-volume $Sink_ID +10%
	else 
		mpc volume +10
	fi
fi

if [[ $1 == "VolDn" ]]; then
	if [[ $Sink_ID ]]; then
		pactl set-sink-input-volume $Sink_ID -10%
	else 
		mpc volume -10
	fi
fi

if [[ $1 == "Mute" ]]; then
	if [[ $Sink_ID ]]; then
		pactl set-sink-input-mute $Sink_ID toggle
	else 
		mpc toggle
	fi
fi

