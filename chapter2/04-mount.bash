#!/bin/bash -e

source as_root.bash

export LFS=/mnt/lfs

if [ ! -d $LFS ]; then
	as_root mkdir -pv $LFS
fi
if ! grep -qs "/dev/sdb1" /proc/mounts; then
	as_root mount -v -t ext4 /dev/sdb1 $LFS
fi

if ! grep -qs "/dev/sdb5" /proc/swaps; then
	as_root /sbin/swapon -v /dev/sdb5
fi