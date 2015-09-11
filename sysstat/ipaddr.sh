#!/bin/sh
#
# Copyright (C) 2015 hehecloud.com
#

MARK=''

if [ -f "/etc/redhat-release" ]; then
     MARK=`grep "CentOS" /etc/redhat-release | grep -e " 7\.."`
fi

if [ "$MARK" = "" ]; then
     echo -n "ipaddr="
     /sbin/ifconfig | `which awk` 'BEGIN{RS=""} /inet / && ($0!~/127.0.0.1/) && ($1!~/lo/) {printf ("%s;", $7)}' | /usr/bin/tr -d "addr:"
else
     echo -n "ipaddr="
     /sbin/ifconfig | `which awk` 'BEGIN{RS=""} /inet / && ($0!~/127.0.0.1/) && ($1!~/lo/) {printf ("%s;", $6)}' | /usr/bin/tr -d "addr:"
fi