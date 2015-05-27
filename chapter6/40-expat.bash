#!/bin/bash -e

source try_unpack.bash

export PKGDIR="expat-2.1.0"

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
echo "./40-expat.sh ran"
