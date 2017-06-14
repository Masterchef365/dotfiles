pacaur -Qql | sort > /tmp/installed
find /home /opt | sort > /tmp/everything
comm -13 /tmp/installed /tmp/everything > everything_but
rm /tmp/installed /tmp/everything
