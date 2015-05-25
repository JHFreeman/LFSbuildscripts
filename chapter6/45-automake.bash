#!/bin/bash -e

source try_unpack.bash



export PKGDIR="automake-1.15"

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

./configure --prefix=/usr --docdir=/usr/share/doc/automake-1.15

make

make install

cd ..
rm -rf $PKGDIR
popd
unset  PKGDIR
echo "./45-automake.sh ran"
source 46-diffutils.sh
