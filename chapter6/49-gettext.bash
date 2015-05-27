#!/bin/bash -e

source try_unpack.bash



export PKGDIR="gettext-0.19.4"

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

./configure --prefix=/usr --docdir=/usr/share/doc/gettext-0.19.4

make

make install

cd ..
rm -rf $PKGDIR
popd
unset  PKGDIR
echo "./49-gettext.sh ran"
