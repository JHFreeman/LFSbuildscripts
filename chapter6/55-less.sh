#!/bin/bash

source try_unpack.sh

export PREV_DIR=$PWD

export PKGDIR="less-458"

cd /sources

try_unpack $PKGDIR

cd $PKGDIR

./configure --prefix=/usr --sysconfdir=/etc

make

make install

cd ..
rm -rf $PKGDIR
cd $PREV_DIR
unset PREV_DIR PKGDIR
echo "./55-less.sh ran"
