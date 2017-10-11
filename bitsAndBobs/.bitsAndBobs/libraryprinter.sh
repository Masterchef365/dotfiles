pdftops "$1"
nc cv-lib-lj600 9100 < "$(basename $1).ps"
