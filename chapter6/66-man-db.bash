#!/bin/bash -e

source try_unpack.bash

export PKGDIR="man-db-2.7.1"

trap 'echo '$PKGDIR'; times' EXIT

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

CFLAGS="-march=native -pipe -O2 -fstack-protector-strong" \
CXXFLAGS="-march=native -pipe -O2 -fstack-protector-strong" \
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
popd
unset  PKGDIR
