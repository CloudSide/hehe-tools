#!/bin/bash
#
# Copyright (C) 2015 hehecloud.com
#

echo -n "cpuidle="

CPU=`/usr/bin/vmstat 1 2`

#original code.commented on 2007.12.11
#if echo -e "$CPU" | grep "id wa" > /dev/null; then
# echo -e "$CPU" | /usr/bin/tail -1 | /bin/awk '{print $(NF-1)}'
#else
# echo -e "$CPU" | /usr/bin/tail -1 | /bin/awk '{print $NF}'
#fi

#modified on 2007.12.11.commented on 2007.12.12
#for ((i=0;i>=0;i++))
#do
# a=`echo -e "$CPU" | /bin/awk "/id/ {print \\$(NF-$i)}"`
# if [ "$a" = "id" ]
# then echo -e "$CPU" | /usr/bin/tail -1 | /bin/awk "{print \$(NF-$i)}"
# break 2
# fi
#done

#modified on 2007.12.12
ID=`echo -e "$CPU" | /bin/sed -n '2p' | /bin/sed -e 's/[[:space:]][[:space:]]*/\n/g' | /bin/sed '1d' | /bin/grep -n "^id$" | /usr/bin/cut -d':' -f 1`
echo -e "$CPU" | /usr/bin/tail -1 | `which awk` "{print \$($ID)}"
