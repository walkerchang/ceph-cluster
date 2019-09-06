#!/bin/bash
FILE_PATH=/home/ubuntu/ceph-cluster/roles/storage-class/files
ADMIN_FILE=$FILE_PATH/admin-secret.yaml
CLIENT_FILE=$FILE_PATH/kube-secret.yaml

## get secret
ADMIN_SECRET=`sudo ceph auth get-key client.admin | base64`
CLIENT_SECRET=`sudo ceph auth get-key client.kube | base64`


## replace secert
sed -i "s/^\(\s*key\s*:\s*\).*$/\1$ADMIN_SECRET/" $ADMIN_FILE
sed -i "s/^\(\s*key\s*:\s*\).*$/\1$CLIENT_SECRET/" $CLIENT_FILE

