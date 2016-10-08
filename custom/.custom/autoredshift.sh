externip=$(dig +short myip.opendns.com @resolver1.opendns.com)
gps=$(geoiplookup -f /usr/share/GeoIP/GeoIPCity.dat $externip | awk '{print $11 $12}' | tr ',' ':')
gps=${gps::-1}
redshift -l $gps
