#!/bin/bash -e

source try_unpack.bash



export PKGDIR="util-linux-2.26"

pushd /sources

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
popd
unset  PKGDIR
echo "./65-util-linux.sh ran"
source 66-man-db.sh
