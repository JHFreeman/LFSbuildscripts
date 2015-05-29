#!/bin/bash -e

source try_unpack.bash

export PKGDIR="diffutils-3.3"

trap 'echo '$PKGDIR'; times' EXIT

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

sed -i 's:= @mkdir_p@:= /bin/mkdir -p:' po/Makefile.in.in

CFLAGS="-march=native -pipe -O2 -fstack-protector-strong" \
CXXFLAGS="-march=native -pipe -O2 -fstack-protector-strong" \
./configure --prefix=/usr

make

make install

cd ..
rm -rf $PKGDIR
popd
unset  PKGDIR
