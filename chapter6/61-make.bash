#!/bin/bash -e

source try_unpack.bash



export PKGDIR="make-4.1"

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
echo "./61-make.sh ran"
