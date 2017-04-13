while read -r a; do
	echo $a | 
	while IFS="" read -r -n 1 b; do
		#printf "%b" "$b"
		printf "$b"
		sleep $1
	done
	echo
done
