#!/bin/bash
FILE_PATH=/home/ubuntu
CEPH_FILE=$FILE_PATH/ceph.conf
SC_EXT4_FILE=class-ext4.yaml
SC_XFS_FILE=class-xfs.yaml

## get monitor ips
MONITOR=`grep -n "mon_host" $CEPH_FILE | awk -F'=' '{print $2}' | sed 's/ //g'`
MONITOR_ADD_PORT=`echo $MONITOR | sed -r 's/,/:6789,/g'`

## replace monitors
sed -i "s/YOUR_MONITOR_IP/$MONITOR_ADD_PORT/g" $SC_EXT4_FILE
sed -i "s/YOUR_MONITOR_IP/$MONITOR_ADD_PORT/g" $SC_XFS_FILE
