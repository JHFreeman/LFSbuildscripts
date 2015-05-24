#!/bin/bash

source try_unpack.sh

export PREV_DIR=$PWD

export PKGDIR="XML-Parser-2.44"

cd /sources

try_unpack $PKGDIR

cd $PKGDIR

perl Makefile.PL

make

make install

cd ..
rm -rf $PKGDIR
cd $PREV_DIR
unset PREV_DIR PKGDIR
echo "./43-XML-Parser.sh ran"
