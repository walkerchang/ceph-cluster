#!/bin/bash
TARGET_WORKSPACE=YOUR-CEPH-PATH/roles/ceph-osd/files
TARGET_MANIFEST=$TARGET_WORKSPACE/ceph-osd.yml
FILENAME=/home/ubuntu/ceph-osd-hosts
CEPH_FILE_PATH=/home/ubuntu

#switch to ceph config directory
cd $CEPH_FILE_PATH

## 抓取要做 ceph osd 的 devices 
CEPH_DISK_DEVICE=`grep -n "CEPH_DISK_DEVICE" $TARGET_WORKSPACE/ceph-osd.yml | awk -F':' '{print $3}'`
str=`echo $CEPH_DISK_DEVICE | sed "s/\[/\"/g" | sed "s/\]/\"/g" | sed 's/"//g'`

## 轉換成 array
OLD_IFS="$IFS" 
IFS="," 
arr=($str) 
IFS="$OLD_IFS" 

exec < $FILENAME

while read line
do
    for device in ${arr[@]}
    do	
        #format disk
        ceph-deploy disk zap $line "/dev/$device"

        #create osd
        ceph-deploy osd create $line --data "/dev/$device"
    done	
done
