#!/bin/bash -e

source try_unpack.bash

export PKGDIR="libpipeline-1.4.0"

trap 'echo '$PKGDIR'; times' EXIT

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

CFLAGS="-march=native -pipe -O2 -fstack-protector-strong" \
CXXFLAGS="-march=native -pipe -O2 -fstack-protector-strong" \
PKG_CONFIG_PATH=/tools/lib/pkgconfig ./configure --prefix=/usr

make

make install

cd ..
rm -rf $PKGDIR
popd
unset  PKGDIR
