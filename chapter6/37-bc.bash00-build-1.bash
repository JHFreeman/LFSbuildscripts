#!/bin/bash -e

source try_unpack.bash

export PKGDIR="bc-1.06.95"

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

patch -Np1 -i ../bc-1.06.95-memory_leak-1.patch

./configure --prefix=/usr           \
            --with-readline         \
            --mandir=/usr/share/man \
            --infodir=/usr/share/info

make

make install

cd ..
rm -rf $PKGDIR
popd
unset  PKGDIR
echo "./37-bc.sh ran"
