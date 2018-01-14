pacman -Qqe | sort > /tmp/installed
pacman -Qqg base base-devel | sort > /tmp/base
comm -13 /tmp/base /tmp/installed > /tmp/manually_installed
cp /tmp/manually_installed /tmp/manually_installed_copy
$EDITOR /tmp/manually_installed
comm -13 /tmp/manually_installed /tmp/manually_installed_copy | sudo pacman -Rns -
