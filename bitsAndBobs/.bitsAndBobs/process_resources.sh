sed -e 's/!.*//g' -e 's;\*\.\([a-z]*[0-9]*\):\s*;#define S_\1 \t;g' -e 's:\n\r::g' -e '/^$/d' | grep -v 'cursorColor'
