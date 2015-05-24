#!/bin/bash

source try_unpack.sh

export PREV_DIR=$PWD

export PKGDIR="gdbm-1.11"

cd /sources

try_unpack $PKGDIR

cd $PKGDIR

./configure --prefix=/usr --enable-libgdbm-compat

make

make install

cd ..
rm -rf $PKGDIR
cd $PREV_DIR
unset PREV_DIR PKGDIR
echo "./39-gdbm.sh ran"
