rm /tmp/depends

echo "Gathering deps..."

for x in /var/lib/pacman/local/*/desc; do
	awk '/%DEPENDS%/{flag=1;next}/%.*/{flag=0}flag' $x >> /tmp/depends
done

echo "Checking unique deps"

sort /tmp/depends | uniq -c | sort -bg | egrep "\s1 " | awk '{print $2}' > /tmp/uniq_deps

echo "Checking deps against others"

for x in /var/lib/pacman/local/*/desc; do
	name=$(awk '/%NAME%/{flag=1;next}/%.*/{flag=0}flag' $x)
	rm /tmp/uniq_count 2>/dev/null
	touch /tmp/uniq_count
	for j in $(awk '/%DEPENDS%/{flag=1;next}/%.*/{flag=0}flag' $x); do
		grep -Fx $j /tmp/uniq_deps >> /tmp/uniq_count
	done
	echo $(wc -l < /tmp/uniq_count)" : "$name
done | sort -bg
rm /tmp/deps /tmp/uniq_count /tmp/uniq_deps 2>/dev/null
