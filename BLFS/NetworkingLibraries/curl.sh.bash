#!/bin/bash -e

source ../get_dir.sh

export URL="http://curl.haxx.se/download/curl-7.40.0.tar.lzma"
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

./configure --prefix=/usr              \
            --disable-static           \
            --enable-threaded-resolver &&
make

make install

cd ..

rm -rf $PKGDIR

rm $FILE

popd

unset PKGDIR FILE URL