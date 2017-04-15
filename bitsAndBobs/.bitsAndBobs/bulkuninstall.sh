#!/bin/bash
echo "Creating list..."
rm /tmp/installed_list /tmp/uninstall_list 2>/dev/null
for x in $(pacaur -Qqte | sort); do
	echo $x >> /tmp/installed_list
	echo $x":"$(pacaur -Qqi $x | grep Description | sed -e 's/^.*\s*: //g')
done | column -t -s ":" > /tmp/uninstall_list
$EDITOR /tmp/uninstall_list
pacaur -Rns $(comm -13 <(awk '{print $1}' /tmp/uninstall_list) /tmp/installed_list 2>/dev/null)
rm /tmp/installed_list /tmp/uninstall_list 2>/dev/null
