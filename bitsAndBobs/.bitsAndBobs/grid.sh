cols=$(tput cols | dc -e '? 4 / p')
lines=$(tput lines | dc -e '? 2 / p')

for x in $(seq $lines); do
	for x in $(seq $cols); do
		echo -n "---+"
	done
	echo
	for x in $(seq $cols); do
		echo -n "   |"
	done
	echo
done
echo
