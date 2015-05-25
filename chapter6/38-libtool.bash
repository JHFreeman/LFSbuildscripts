#!/bin/bash -e

source try_unpack.bash

export PKGDIR="libtool-2.4.6"

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

./configure --prefix=/usr

make

make install

cd ..
rm -rf $PKGDIR
popd
unset  PKGDIR
echo "./38-libtool.sh ran"
source 39-gdbm.sh
