#!/bin/bash -e

source try_unpack.bash

export PKGDIR="patch-2.7.5"

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
