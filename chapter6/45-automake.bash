#!/bin/bash -e

source try_unpack.bash

export PKGDIR="automake-1.15"

trap 'echo '$PKGDIR'; times' EXIT

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

CFLAGS="-march=native -pipe -O2 -fstack-protector-strong" \
CXXFLAGS="-march=native -pipe -O2 -fstack-protector-strong" \
./configure --prefix=/usr --docdir=/usr/share/doc/automake-1.15

make

make install

cd ..
rm -rf $PKGDIR
popd
unset  PKGDIR
