#!/bin/bash -e

source try_unpack.bash

export PKGDIR="bc-1.06.95"

trap 'echo '$PKGDIR'; times' EXIT

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

patch -Np1 -i ../bc-1.06.95-memory_leak-1.patch

CFLAGS="-march=native -pipe -O2 -fstack-protector-strong" \
CXXFLAGS="-march=native -pipe -O2 -fstack-protector-strong" \
./configure --prefix=/usr           \
            --with-readline         \
            --mandir=/usr/share/man \
            --infodir=/usr/share/info

make

make install

cd ..
rm -rf $PKGDIR
popd
unset  PKGDIR CFLAGS CXXFLAGS
