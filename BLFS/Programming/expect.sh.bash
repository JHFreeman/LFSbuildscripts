#!/bin/bash

source ../get_dir.sh
URL="http://prdownloads.sourceforge.net/expect/expect5.45.tar.gz"
FILE=${URL##*/}

pushd /sources

if [ -e $FILE ]; then
	rm $FILE
fi

wget $URL

PKGDIR=$(get_dir $FILE)

if [ -d $PKGDIR ]; then
	rm -rf $PKGDIR
fi

tar -xf ${FILE}

cd $PKGDIR

./configure --prefix=/usr           \
            --with-tcl=/usr/lib     \
            --enable-shared         \
            --mandir=/usr/share/man \
            --with-tclinclude=/usr/include &&
make

make install &&
ln -svf expect5.45/libexpect5.45.so /usr/lib

cd ..

rm -rf $PKGDIR

rm $FILE

popd

unset FILE PKGDIR URL