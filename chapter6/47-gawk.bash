#!/bin/bash -e

source try_unpack.bash



export PKGDIR="gawk-4.1.2"

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
echo "./47-gawk.sh ran"
