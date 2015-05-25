#!/bin/bash -e

source try_unpack.bash



export PKGDIR="groff-1.22.3"

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

PAGE=letter ./configure --prefix=/usr

make

make install

cd ..
rm -rf $PKGDIR
popd
unset  PKGDIR
echo "./52-groff.sh ran"
source 53-xz.sh
