#!/bin/bash -e

source try_unpack.bash

export PKGDIR="kbd-2.0.2"

trap 'echo '$PKGDIR'; times' EXIT

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

patch -Np1 -i ../kbd-2.0.2-backspace-1.patch

sed -i 's/\(RESIZECONS_PROGS=\)yes/\1no/g' configure
sed -i 's/resizecons.8 //' docs/man/man8/Makefile.in

CFLAGS="-march=native -pipe -O2 -fstack-protector-strong" \
CXXFLAGS="-march=native -pipe -O2 -fstack-protector-strong" \
PKG_CONFIG_PATH=/tools/lib/pkgconfig ./configure --prefix=/usr --disable-vlock

make

make install

cd ..
rm -rf $PKGDIR
popd
unset  PKGDIR
