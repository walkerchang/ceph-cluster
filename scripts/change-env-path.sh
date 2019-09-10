#!/bin/bash

## change k8s and ceph env path
CEPH_WORKSPACE=$1
KUBESPRAY_WORKSPACE=$2
KUBESPRAY_ENV=$3

cd $CEPH_WORKSPACE

all_files=(
    roles/ceph-osd/defaults/main.yml
    roles/storage-class/defaults/main.yml
    roles/ceph-add-mon/defaults/main.yml
)

for file in ${all_files[@]}
do
    sed -i "s%\(CEPH_WORKSPACE:\s*\).*$%\1$CEPH_WORKSPACE%" $file
done

all_sh_files=(
    roles/storage-class/files/change-secret.sh
    scripts/create-osd.sh
)

for file in ${all_sh_files[@]}
do
    sed -i "s%YOUR-CEPH-PATH%$CEPH_WORKSPACE%" $file
done

all_k8s_files=(
    roles/modify-k8s-pods/defaults/main.yml
)


for file in ${all_k8s_files[@]}
do
    sed -i "s%YOUR-K8S-PATH%$KUBESPRAY_WORKSPACE%" $file
    sed -i "s%YOUR-K8S-ENV%$KUBESPRAY_ENV%" $file
done




