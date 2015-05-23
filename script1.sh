#!/bin/bash

as_root()
{
	if	[ $EUID = 0 ];	then $*
	elif	[ -x /usr/bin/sudo ];	then sudo $*
	else	su -c \\"$*\\"
	fi
}

export -f as_root

#export LFS=/mnt/lfs

#mkdir -pv $LFS

#mount -v -t ext4 /dev/sdb1 $LFS

#/sbin/swapon /dev/sdb5

mkdir -v $LFS/sources

chmod -v a+wt $LFS/sources

pushd $LFS/sources

wget http://www.linuxfromscratch.org/lfs/view/stable-systemd/wget-list

wget --input-file=wget-list --continue --directory-prefix=$LFS/sources

wget http://www.linuxfromscratch.org/lfs/view/stable-systemd/md5sums

md5sum -c md5sums

popd

mkdir -v $LFS/tools

ln -sv $LFS/tools /

#groupadd lfs

#useradd -s /bin/bash -g lfs -m -k /dev/null lfs
