while read -r line; do echo $line | rev | base64; done
