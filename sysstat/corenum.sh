#!/bin/sh
#
# Copyright (C) 2015 hehecloud.com
#

awk=`which awk`
#CORENUM=`cat /proc/cpuinfo | grep processor | awk '{print FNR}' | tail -1`
physicalid=`cat /proc/cpuinfo | grep "physical id" | $awk 'BEGIN{pid=0}{if($4>pid){pid=$4}}END{print pid+1}'`
corenum=`cat /proc/cpuinfo | grep "cpu cores" | $awk 'BEGIN{corenum=0}{if($4>corenum){corenum=$4}}END{print corenum}'`
echo -n "corenum="
num=`expr $physicalid \* $corenum`
if [ $num -eq "0" ]; then
    echo `cat /proc/cpuinfo | grep processor | wc -l`
else
    echo $num
fi