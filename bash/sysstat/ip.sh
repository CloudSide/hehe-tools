#!/bin/bash -x

Private_IPv4="Private_IPv4: "
Public_IPv4="Public_IPv4: "
Private_IPv4_LIST="127.0.0.0-127.255.255.255 10.0.0.0-10.255.255.255 172.16.0.0-172.31.255.255 192.168.0.0-192.168.255.255 100.64.0.0-100.127.255.255"
Exclude="docker|veth|vxlan"
Re_IP="((2[0-4]\d|25[0-5]|[01]?\d\d?)\.){3}(2[0-4]\d|25[0-5]|[01]?\d\d?)"
Check_IP=`which ip`


if [[ $? -ne 0 ]];then
    echo "No ip Command"
    exit
else
    IP_LIST=`ip addr | grep -vE $Exclude | grep -Po $Re_IP | sort -n | uniq`
fi

To_IPv4 () {
    H1=$(($1 & 0x000000ff)) 
    H2=$((($1 & 0x0000ff00) >> 8)) 
    L1=$((($1 & 0x00ff0000) >> 16)) 
    L2=$((($1 & 0xff000000) >> 24)) 
    echo $L2.$L1.$H2.$H1 
}

To_10 () {
    IP_A=`echo $1 | awk -F '.' '{print $1}'`
    IP_B=`echo $1 | awk -F '.' '{print $2}'`
    IP_C=`echo $1 | awk -F '.' '{print $3}'`
    IP_D=`echo $1 | awk -F '.' '{print $4}'`
    echo $(( ${IP_A}<<24 | ${IP_B}<<16 | ${IP_C}<<8 | ${IP_D} ))
}

Is_IPv4 () {
    Start_IP=`echo $1 | awk -F '-' '{print $1}'`
    Stop_IP=`echo $1  | awk -F '-' '{print $2}'`
    Start_IP_10=`To_10 $Start_IP`
    Stop_IP_10=`To_10 $Stop_IP`
    IS_IP_10=`To_10 $2`
    if (( "$IS_IP_10" <= "$Stop_IP_10" )) && (( "$IS_IP_10" >= "$Start_IP_10" ));then
        return 0
    else
        return 1
    fi
}

To_Init () {
    IP=$1
    for IP_IP in $Private_IPv4_LIST;do
        Is_IPv4 ${IP_IP} $IP
        if (( "$?" == "0" ));then
            return 0
        fi
    done
    return 1
}

for ip in $IP_LIST;do
    To_Init $ip
    if (( "$?" == "0" ));then
        Private_IPv4="$Private_IPv4 $ip"
    else
        Public_IPv4="$Public_IPv4 $ip"
    fi
done

echo $Private_IPv4
echo $Public_IPv4

