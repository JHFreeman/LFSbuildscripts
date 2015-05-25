#!/bin/bash -e

source ../get_dir.sh
URL="http://ftp.gnu.org/gnu/libunistring/libunistring-0.9.5.tar.xz"
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

./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/libunistring-0.9.5 &&
make

make install

cd ..

rm -rf $PKGDIR

rm $FILE

popd

unset FILE PKGDIR URL