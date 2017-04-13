comm -23 <(pacaur -Qqe | sort) <(echo $(pacaur -Qqs base && pacaur -Qqs base-devel) | sort) > install_list.txt
