#!/bin/bash -e

source try_unpack.bash

export PKGDIR="gdbm-1.11"

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

./configure --prefix=/usr --enable-libgdbm-compat

make

make install

cd ..
rm -rf $PKGDIR
popd
unset  PKGDIR
echo "./39-gdbm.sh ran"
