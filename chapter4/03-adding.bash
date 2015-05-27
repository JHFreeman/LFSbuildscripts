#!/bin/bash -e

LFS=/mnt/lfs

if ! grep -qs "lfs" /etc/group; then
	groupadd lfs
fi
if ! grep -qs "lfs" /etc/passwd; then
	useradd -s /bin/bash -g lfs -m -k /dev/null lfs
fi

echo "lfs"  | passwd lfs --stdin 

#To access vm shared directory after chroot
if [ ! -d $LFS/Home ]; then
	mkdir -v $LFS/Home
fi

if ! grep -qs "$LFS/Home" /proc/mounts; then
	mount -v -t prl_fs Home $LFS/Home
fi

chown -v lfs $LFS/tools

chown -v lfs $LFS/sources

su - lfs
