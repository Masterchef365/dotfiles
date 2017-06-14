#!/bin/bash
interface_dir="/home/duncan/Projects/Home/Rust/FRAME/interface_prototype/"
cli=$interface_dir"target/debug/interface_prototype"
cd $interface_dir

dmenu_cmd="dmenu -l 61"
#dmenu_cmd="rofi -dmenu"

get_date () {
	date +%s -d "$(echo | $dmenu_cmd -p $1)"
}

get_string () {
	echo | $dmenu_cmd -p $1
}

get_duration () {
	echo $(( $(get_date $1) - $(date +%s) ))
}

from_unix () {
	date -d @"$1" +'%D %R'
}

from_unix_duration () {
	echo "$(($1 / 3600))h $((($1 / 60) % 60))m $(($1 % 60))s"
}

conv_query () {
	case $1 in
		"event")
			echo "$1 $2: [$(from_unix $3)] [$(from_unix $4)] ($(from_unix_duration $5))"
			;;
		"error")
			echo $@
			;;
		"rep")
			echo "$1 $2: [$(from_unix $3)] [$(from_unix $4)] ($(from_unix_duration $5)) ($(from_unix_duration $6))"
			;;
		*)
			echo $@
			;;
	esac
}

conv_query_batch () {
	while read -r line; do
		conv_query $line
	done
}

operation=`echo "3days
add
del
show
query
rep" | $dmenu_cmd -p "Operation: "`

case $operation in
	add) $cli $operation $(get_string 'Name: ') $(get_date 'Start_constraint: ') $(get_date 'End_constraint: ') $(get_duration 'Duration: ')
		;;
	rep) $cli $operation $(get_string 'Name: ') $(get_date 'Start_constraint: ') $(get_date 'End_constraint: ') $(get_duration 'Duration: ') $(get_duration 'Interval: ')
		;;
	query) $cli $operation $(get_date 'Start_constraint: ') $(get_date 'End_constraint: ') | conv_query_batch | column -t | $dmenu_cmd -p ""
		;;
	3days) $cli query $(date +%s) $(date +%s -d '3 days') | conv_query_batch | column -t | $dmenu_cmd -p ""
		;;
	del) $cli $operation $($cli show | conv_query_batch | $dmenu_cmd -p 'Name: ' | sed -e 's/.*\s\(.*\):\s.*/\1/g')
		;;
	show) $cli $operation | conv_query_batch | column -t | $dmenu_cmd -p ""
		;;
esac

#TODO: Add a 'concrete' function somehow
#TODO: Nested event repeaters (endpoint of one is an enum, either another repeater or and event which ends it)
