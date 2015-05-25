#!/bin/bash -e

source ../get_dir.sh
export URL="http://www.libarchive.org/downloads/libarchive-3.1.2.tar.gz"
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

./configure --prefix=/usr --disable-static &&
make

make install

cd ..

rm -rf $PKGDIR

rm $FILe

popd

unset PKGDIR FILE URL