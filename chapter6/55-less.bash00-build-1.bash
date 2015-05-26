#!/bin/bash -e

source try_unpack.bash



export PKGDIR="less-458"

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

./configure --prefix=/usr --sysconfdir=/etc

make

make install

cd ..
rm -rf $PKGDIR
popd
unset  PKGDIR
echo "./55-less.sh ran"
source 56-gzip.sh
