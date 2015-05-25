#!/bin/bash -e

source try_unpack.bash



export PKGDIR="autoconf-2.69"

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
echo "./44-autoconf.sh ran"
source 45-automake.sh
