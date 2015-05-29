#!/bin/bash -e

source try_unpack.bash

export PKGDIR="tar-1.28"

trap 'echo '$PKGDIR'; times' EXIT

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

CFLAGS="-march=native -pipe -O2 -fstack-protector-strong" \
CXXFLAGS="-march=native -pipe -O2 -fstack-protector-strong" \
FORCE_UNSAFE_CONFIGURE=1  \
./configure --prefix=/usr \
            --bindir=/bin
            
make

make install
make -C doc install-html docdir=/usr/share/doc/tar-1.28

cd ..
rm -rf $PKGDIR
popd
unset  PKGDIR
