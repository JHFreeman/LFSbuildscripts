#!/bin/bash

source try_unpack.sh

export PREV_DIR=$PWD

export PKGDIR="iproute2-3.19.0"

cd /sources

try_unpack $PKGDIR

cd $PKGDIR

sed -i '/^TARGETS/s@arpd@@g' misc/Makefile
sed -i /ARPD/d Makefile
sed -i 's/arpd.8//' man/man8/Makefile

make

make DOCDIR=/usr/share/doc/iproute2-3.19.0 install

cd ..
rm -rf $PKGDIR
cd $PREV_DIR
unset PREV_DIR PKGDIR
echo "./57-iproute.sh ran"
