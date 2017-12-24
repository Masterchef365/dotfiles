tmp_name=/tmp/exempt
cat << EOF > tmp_name
.
./.cargo
./.config
./.local
./.mozilla
./.steam
./.themes
./.Xauthority
EOF
find . -maxdepth 1 -name ".*" ! -type l | sort | comm -32 - tmp_name | while read -r del; do rm -rf "$del"; done
rm tmp_name
