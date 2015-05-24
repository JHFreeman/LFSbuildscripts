#!/bin/bash

source try_unpack.sh

export PREV_DIR=$PWD

export PKGDIR="diffutils-3.3"

cd /sources

try_unpack $PKGDIR

cd $PKGDIR

sed -i 's:= @mkdir_p@:= /bin/mkdir -p:' po/Makefile.in.in

./configure --prefix=/usr

make

make install

cd ..
rm -rf $PKGDIR
cd $PREV_DIR
unset PREV_DIR PKGDIR
echo "./46-diffutils.sh ran"
