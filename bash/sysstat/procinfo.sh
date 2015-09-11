#!/bin/sh
#
# Copyright (C) 2015 hehecloud.com
#

TMPF=/tmp/ps.tmp

/bin/ps ax > $TMPF

echo -n "process="
/bin/cat $TMPF | /usr/bin/wc -l | /usr/bin/xargs

echo -n "httpd="
/bin/grep -c httpd $TMPF | /usr/bin/xargs

[ -f $TMPF ] && /bin/rm -f $TMP