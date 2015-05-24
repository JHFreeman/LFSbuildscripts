#!/bin/bash

source try_unpack.sh

export PREV_DIR=$PWD

export PKGDIR="util-linux-2.26"

cd /sources

try_unpack $PKGDIR

cd $PKGDIR

mkdir -pv /var/lib/hwclock

./configure ADJTIME_PATH=/var/lib/hwclock/adjtime   \
            --docdir=/usr/share/doc/util-linux-2.26 \
            --disable-chfn-chsh  \
            --disable-login      \
            --disable-nologin    \
            --disable-su         \
            --disable-setpriv    \
            --disable-runuser    \
            --disable-pylibmount \
            --without-python
            
make

make install

cd ..
rm -rf $PKGDIR
cd $PREV_DIR
unset PREV_DIR PKGDIR
echo "./65-util-linux.sh ran"
