#!/bin/bash -e

source ../get_dir.sh

URL="http://ftp.gnu.org/gnu/parted/parted-3.2.tar.xz"
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

./configure --prefix=/usr --disable-static &&
make

make install

cd ..

rm -rf $PKGDIR $FILE

popd
