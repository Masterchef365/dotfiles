pacaur -Qqe | sort > /tmp/installed
pacaur -Qqg base base-devel | sort > /tmp/base
comm -13 /tmp/base /tmp/installed > install_list.txt
rm /tmp/installed /tmp/base
