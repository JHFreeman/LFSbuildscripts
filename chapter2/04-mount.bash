#!/bin/bash -e

export LFS=/mnt/lfs

if [ ! -d $LFS ]; then
	mkdir -pv $LFS
fi
if ! grep -qs "/dev/sdb1" /proc/mounts; then
	mount -v -t ext4 /dev/sdb1 $LFS
fi

if ! grep -qs "/dev/sdb5" /proc/swaps; then
	/sbin/swapon -v /dev/sdb5
fi