#!/bin/bash -e

LFS=/mnt/lfs

pushd $LFS/sources

wget http://www.linuxfromscratch.org/lfs/view/stable-systemd/wget-list

wget --continue --input-file=wget-list

wget http://www.nico.schottelius.org/software/gpm/archives/gpm-1.20.7.tar.bz2

wget ftp://ftp.isc.org/isc/dhcp/4.3.1/dhcp-4.3.1.tar.gz

wget http://www.linuxfromscratch.org/patches/blfs/systemd/dhcp-4.3.1-client_script-1.patch

wget http://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-6.7p1.tar.gz

wget ftp://ftp.openssl.org/source/openssl-1.0.2.tar.gz

wget http://www.linuxfromscratch.org/patches/blfs/systemd/openssl-1.0.2-fix_parallel_build-1.patch

wget http://ftp.gnu.org/gnu/wget/wget-1.16.1.tar.xz

wget http://www.linuxfromscratch.org/blfs/downloads/systemd/blfs-systemd-units-20150210.tar.bz2

tar -xf blfs-systemd-units-20150210.tar.bz2

chown -v lfs $LFS/tools

chown -v lfs $LFS/sources

su - lfs

cat > ~/.bash_profile << "EOF"
exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
EOF

cat > ~/.bashrc << "EOF"
set +h
umask 022
LFS=/mnt/lfs
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/tools/bin:/bin:/usr/bin
export LFS LC_ALL LFS_TGT PATH
EOF

source ~/.bash_profile

tar -xf binutils-2.25.tar.bz2

mkdir -v binutils-build
cd binutils-build

../binutils-2.25/configure     \
    --prefix=/tools            \
    --with-sysroot=$LFS        \
    --with-lib-path=/tools/lib \
    --target=$LFS_TGT          \
    --disable-nls              \
    --disable-werror
    
make

case $(uname -m) in
x86_64) mkdir -v /tools/lib && ln -sv lib /tools/lib64 ;;
esac

