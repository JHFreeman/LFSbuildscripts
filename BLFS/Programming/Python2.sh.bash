#!/bin/bash

source ../get_dir.sh
URL="https://www.python.org/ftp/python/2.7.9/Python-2.7.9.tar.xz"
FILE=${URL##*/}

pushd /sources

if [ -e $FILE ]; then
	rm $FILE
fi

wget $URL

PKGDIR=$(get_dir ${FILE})

if [ -d $PKGDIR ]; then
	rm -rf $PKGDIR
fi

tar -xf ${FILE}

cd $PKGDIR

./configure --prefix=/usr       \
            --enable-shared     \
            --with-system-expat \
            --with-system-ffi   \
            --enable-unicode=ucs4 &&
make

make install &&
chmod -v 755 /usr/lib/libpython2.7.so.1.0

cd ..

rm -rf $PKGDIR $FILE

popd

unset PKGDIR FILE URL