#!/bin/bash

source try_unpack.sh

export PREV_DIR=$PWD

export PKGDIR="libtool-2.4.6"

cd /sources

try_unpack $PKGDIR

cd $PKGDIR

./configure --prefix=/usr

make

make install

cd ..
rm -rf $PKGDIR
cd $PREV_DIR
unset PREV_DIR PKGDIR
echo "./38-libtool.sh ran"
