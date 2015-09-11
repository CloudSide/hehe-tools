#!/bin/sh
#
# Copyright (C) 2015 hehecloud.com
#

echo -n diskuse=
#add by pgt
#/bin/df -k | /bin/awk '/^\/dev/ {printf("%s %sM %s;",$6,substr($2, 1, length($2)-3),$5);}'
#/bin/df -k | /usr/bin/awk '/^\/dev/ {printf("%s %sM %s;",$6,substr($2, 1, length($2)-3),$5);}'
/bin/df -lk | `which awk` 'BEGIN {mark=0} {if(/^\/dev/ && $2) {printf("%s %sM %s;",$6,substr($2, 1, length($2)-3),$5);} else if(/^\/dev/ && !$2){mark=1;} else if(mark==1){printf("%s %sM %s;",$5,substr($1, 1, length($1)-3),$4);mark=0;}}'
echo