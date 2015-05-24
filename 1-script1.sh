#!/bin/bash

export LOGFILENAME="1-script1.sh.log"

source as_root.sh

export LFS=/mnt/lfs

if grep -qs '$LFS' /proc/mounts; then
	as_root umount -fv $LFS
fi

if [ -d $LFS ]; then
	as_root rm -rf $LFS
fi

if grep -qs '/dev/sdb5' /proc/swaps; then
	as_root /sbin/swapoff /dev/sdb5
fi

if [ ! -d $LFS ]; then
	as_root mkdir -pv $LFS
	if [ $? -eq 0 ]; then
		as_root echo "made directory $LFS." >> $LOGFILENAME
	else
		as_root echo "mkdir -pv $LFS failed" >> $LOGFILENAME
	fi
fi

if ! grep -qs '$LFS' /proc/mounts; then
	as_root mount -v -t ext4 /dev/sdb1 $LFS
	if [ $? -eq 0 ]; then
		as_root echo "mounted /dev/sdb1 to $LFS" >> $LOGFILENAME
	else
		as_root echo "mounting /dev/sdb1 failed for some reason" >> $LOGFILENAME
	fi
fi

if ! grep -qs '/dev/sdb5' /proc/swaps; then
	as_root /sbin/swapon /dev/sdb5
	if [ $? -eq 0 ]; then
		as_root echo "mounted /dev/sdb5" >> $LOGFILENAME
	else
		as_root echo "mounting swap failed for some reason" >> $LOGFILENAME
	fi
fi

if [ ! -d $LFS/sources ]; then
	as_root mkdir -v $LFS/sources
	if [ $? -eq 0 ]; then
		as_root echo "made directory $LFS/sources" >> $LOGFILENAME	
	else
		as_root echo "was unable to make $LFS/sources" >> $LOGFILENAME
	fi
fi

as_root chmod -v a+wt $LFS/sources

pushd $LFS/sources

as_root wget http://www.linuxfromscratch.org/lfs/view/stable-systemd/wget-list

as_root wget --input-file=wget-list --continue --directory-prefix=$LFS/sources

as_root wget http://www.linuxfromscratch.org/lfs/view/stable-systemd/md5sums

as_root md5sum -c md5sums

as_root wget ftp://ftp.isc.org/isc/dhcp/4.3.1/dhcp-4.3.1.tar.gz --directory-prefix=$LFS/sources

as_root wget http://www.linuxfromscratch.org/patches/blfs/systemd/dhcp-4.3.1-client_script-1.patch --directory-prefix=$LFS/sources

as_root wget http://www.linuxfromscratch.org/blfs/downloads/systemd/blfs-systemd-units-20150210.tar.bz2 --directory-prefix=$LFS/sources

as_root wget http://www.openssl.org/source/openssl-1.0.2.tar.gz --directory-prefix=$LFS/sources

as_root wget http://www.linuxfromscratch.org/patches/blfs/systemd/openssl-1.0.2-fix_parallel_build-1.patch --directory-prefix=$LFS/sources

as_root wget http://anduin.linuxfromscratch.org/sources/other/certdata.txt --directory-prefix=$LFS/sources

as_root wget http://ftp.gnu.org/gnu/wget/wget-1.16.1.tar.xz --directory-prefix=$LFS/sources

popd

if [ ! -d $LFS/tools ]; then
	as_root mkdir -v $LFS/tools
fi

if [ ! -h /tools ]; then
	as_root ln -sv $LFS/tools /
fi

if ! grep -qs 'lfs' /etc/group; then
	as_root groupadd lfs
fi

if ! grep -qs 'lfs' /etc/passwd; then
	as_root useradd -s /bin/bash -g lfs -m -k /dev/null lfs
fi

as_root chown -v lfs $LFS/tools

as_root chown -v lfs $LFS/sources

unset LOGFILENAME