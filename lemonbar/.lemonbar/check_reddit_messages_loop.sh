#!/bin/bash
#Kill other running instances
for pid in $(pidof -x $0); do
	if [ $pid != $$ ]; then
		kill -9 $pid
	fi 
done
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
