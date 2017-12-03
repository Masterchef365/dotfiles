current=`i3-msg -t get_workspaces | jq '.[] | select(.focused==true).name' | cut -d"\"" -f2`
num=`i3-msg -t get_workspaces | jq '.[] | select(.focused==true).num' | cut -d"\"" -f2`
rename="$(rofi -dmenu)"
if [ -n "$rename" ]; then
	i3-msg rename workspace \"$current\" to \"$num: $rename\"
else
	i3-msg rename workspace \"$current\" to \"$num\"
fi
