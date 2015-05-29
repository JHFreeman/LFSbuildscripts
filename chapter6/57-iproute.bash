#!/bin/bash -e

source try_unpack.bash

export PKGDIR="iproute2-4.0.0"

trap 'echo '$PKGDIR'; times' EXIT

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

sed -i '/^TARGETS/s@arpd@@g' misc/Makefile
sed -i /ARPD/d Makefile
sed -i 's/arpd.8//' man/man8/Makefile

make

make DOCDIR=/usr/share/doc/iproute2-4.0.0 install

cd ..
rm -rf $PKGDIR
popd
unset  PKGDIR
