#!/bin/bash -e

source try_unpack.bash

export PKGDIR="gawk-4.1.2"

trap 'echo '$PKGDIR'; times' EXIT

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

CFLAGS="-march=native -pipe -O2 -fstack-protector-strong" \
CXXFLAGS="-march=native -pipe -O2 -fstack-protector-strong" \
./configure --prefix=/usr

make

make install

cd ..
rm -rf $PKGDIR
popd
unset  PKGDIR
