while read -r line; do echo $line | base64 -d | rev; done
