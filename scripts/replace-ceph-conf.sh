#!/bin/bash

CEPH_FILE_PATH=/home/ubuntu
TMP_FILE_PATH=/tmp

TARGET_FILE=$CEPH_FILE_PATH/ceph.conf
TMP_FILE=$TMP_FILE_PATH/ceph.conf

## 抓取要更改的項目
MON_INITIAL_MEMBERS=`grep -n "mon_initial_members" $TMP_FILE | awk -F'=' '{print $2}' | sed 's/ //g'`
MON_HOST=`grep -n "mon_host" $TMP_FILE | awk -F'=' '{print $2}' | sed 's/ //g'`

sed -i "s/^\(mon_initial_members\s*=\s*\).*$/\1$MON_INITIAL_MEMBERS/" $TARGET_FILE
sed -i "s/^\(mon_host\s*=\s*\).*$/\1$MON_HOST/" $TARGET_FILE

