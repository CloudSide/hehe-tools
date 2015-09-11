#!/bin/sh
#
# Copyright (C) 2015 hehecloud.com
#

export PATH=/bin:/usr/bin

sort=`which sort`

echo users=`/usr/bin/who | cut -d " " -f 1 | $sort | /usr/bin/uniq -c | /usr/bin/xargs`