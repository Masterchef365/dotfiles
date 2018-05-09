for x in $(pacman -Qqte); do
	echo $(pactree -u $x | wc -l | tr '\n' ' ') $x
done | sort -rh
