#!/bin/bash
FILE_PATH=/home/ubuntu
CEPH_FILE=$FILE_PATH/ceph.conf
TARGET_FILE=class.yaml

## get monitor ips
MONITOR=`grep -n "mon_host" $CEPH_FILE | awk -F'=' '{print $2}' | sed 's/ //g'`
MONITOR_ADD_PORT=`echo $MONITOR | sed -r 's/,/:6789,/g'`

## replace monitors
sed -i "s/YOUR_MONITOR_IP/$MONITOR_ADD_PORT/g" $TARGET_FILE

