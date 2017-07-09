while read -r line; do
	echo $line | festival --tts
done
