#!/bin/bash

source try_unpack.sh

export PREV_DIR=$PWD

export PKGDIR="kmod-19"

cd /sources

try_unpack $PKGDIR

cd $PKGDIR

./configure --prefix=/usr          \
            --bindir=/bin          \
            --sysconfdir=/etc      \
            --with-rootlibdir=/lib \
            --with-xz              \
            --with-zlib
            
make

make install

for target in depmod insmod lsmod modinfo modprobe rmmod; do
  ln -sv ../bin/kmod /sbin/$target
done

ln -sv kmod /bin/lsmod

cd ..
rm -rf $PKGDIR
cd $PREV_DIR
unset PREV_DIR PKGDIR
echo "./59-kmod.sh ran"
