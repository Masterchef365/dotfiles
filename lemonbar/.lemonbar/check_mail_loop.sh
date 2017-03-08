#!/bin/bash
#Kill other running instances
for pid in $(pidof -x $0); do
	if [ $pid != $$ ]; then
		kill -9 $pid
	fi 
done
source ~/.private.sh
while true; do
	curl -u $username@gmail.com:$password --silent "https://mail.google.com/mail/feed/atom" | 
	xmllint --format - | 
	grep "<entry>" | 
	wc -l | 
	tr -d '\r\n' > /tmp/mailtemp.tmp
	sleep 50
done

