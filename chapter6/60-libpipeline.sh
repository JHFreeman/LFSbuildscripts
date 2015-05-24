#!/bin/bash

source try_unpack.sh

export PREV_DIR=$PWD

export PKGDIR="libpipeline-1.4.0"

cd /sources

try_unpack $PKGDIR

cd $PKGDIR

PKG_CONFIG_PATH=/tools/lib/pkgconfig ./configure --prefix=/usr

make

make install

cd ..
rm -rf $PKGDIR
cd $PREV_DIR
unset PREV_DIR PKGDIR
echo "./60-libpipeline.sh ran"
