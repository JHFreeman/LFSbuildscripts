#!/bin/bash -e

LFS=/mnt/lfs

groupadd lfs
useradd -s /bin/bash -g lfs -m -k /dev/null lfs


echo "lfs"  | as_root passwd lfs --stdin 

#To access vm shared directory after chroot
if [ ! -d $LFS/Home ]; then
	mkdir -v $LFS/Home
fi

mount -v -t prl_fs Home $LFS/Home

chown -v lfs $LFS/tools

chown -v lfs $LFS/sources

su - lfs -c "cd /linuxbuild/chapter4"
