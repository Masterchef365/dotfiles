externip=$(dig +short myip.opendns.com @resolver1.opendns.com)
gps=$(geoiplookup -f /usr/share/GeoIP/GeoIPCity.dat $externip | awk '{print $12 $13}' | tr ',' ':')
gps=${gps::-1}
echo $gps
redshift -rl $gps
