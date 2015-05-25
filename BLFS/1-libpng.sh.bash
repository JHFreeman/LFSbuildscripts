#!/bin/bash -e

source try_unpack.sh

export PKGDIR="libpng-1.6.16"

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

gzip -cd ../libpng-1.6.16-apng.patch.gz | patch -p1

./configure --prefix=/usr --disable-static

make

make install

cd ..

rm -rf $PKGDIR

popd

unset PKGDIR