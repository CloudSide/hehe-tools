#!/bin/sh
#
# Copyright (C) 2015 hehecloud.com
#

/usr/bin/uptime | `which awk` 'BEGIN { FS=" "; RS="\n"; ORS=""; } { \
                                print "uptime=";
                                for (i=3; i<NF-6; i++) print $i " ";
                                print "\n";
                                print "load=";
                                for (i=NF-2; i<=NF; i++) print $i " ";
                                print "\n"; }'