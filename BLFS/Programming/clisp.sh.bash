#!/bin/bash

source ../get_dir.sh
export URL="http://ftp.gnu.org/pub/gnu/clisp/latest/clisp-2.49.tar.bz2"
export FILE=${URL##*/}

pushd /sources

if [ -e $FILE ]; then
	rm $FILE
fi

wget $URL

export PKGDIR=$(get_dir ${FILE})

if [ -d $PKGDIR ]; then
	rm -rf $PKGDIR
fi

tar -xf ${FILE}

cd $PKGDIR

sed -i '/socket/d' tests/tests.lisp

mkdir build &&
cd    build &&

../configure --srcdir=../                       \
             --prefix=/usr                      \
             --docdir=/usr/share/doc/clisp-2.49 \
             --with-libsigsegv-prefix=/usr &&

ulimit -s 16384 &&
make -j1

make install

cd ../..

rm -rf $PKGDIR

rm $FILE

popd

unset URL FILE PKGDIR