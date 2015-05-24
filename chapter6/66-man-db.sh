#!/bin/bash

source try_unpack.sh

export PREV_DIR=$PWD

export PKGDIR="man-db-2.7.1"

cd /sources

try_unpack $PKGDIR

cd $PKGDIR

./configure --prefix=/usr                        \
            --docdir=/usr/share/doc/man-db-2.7.1 \
            --sysconfdir=/etc                    \
            --disable-setuid                     \
            --with-browser=/usr/bin/lynx         \
            --with-vgrind=/usr/bin/vgrind        \
            --with-grap=/usr/bin/grap
            
make

make install

sed -i "s:man root:root root:g" /usr/lib/tmpfiles.d/man-db.conf

cd ..
rm -rf $PKGDIR
cd PREV_DIR
unset PREV_DIR PKGDIR
echo "./66-man-db.sh ran"
