#!/bin/bash -e

source try_unpack.sh

export PKGDIR="nano-2.3.6"

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

./configure --prefix=/usr     \
            --sysconfdir=/etc \
            --enable-utf8     \
            --docdir=/usr/share/doc/nano-2.3.6 &&
            --with-slang
make

make install
cd ..
rm -rf $PKGDIR
popd
unset PKGDIR