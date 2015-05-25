#!/bin/bash -e

source try_unpack.bash



export PKGDIR="patch-2.7.4"

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
echo "./62-patch.sh ran"
source 63-systemd.sh
