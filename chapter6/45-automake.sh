#!/bin/bash

source try_unpack.sh

export PREV_DIR=$PWD

export PKGDIR="automake-1.15"

cd /sources

try_unpack $PKGDIR

cd $PKGDIR

./configure --prefix=/usr --docdir=/usr/share/doc/automake-1.15

make

make install

cd ..
rm -rf $PKGDIR
cd $PREV_DIR
unset PREV_DIR PKGDIR
echo "./45-automake.sh ran"
