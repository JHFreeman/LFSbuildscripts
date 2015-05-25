#!/bin/bash -e

source ../get_dir.sh

export URL="http://ftp.gnu.org/gnu/libsigsegv/libsigsegv-2.10.tar.gz"
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

tar -xf $FILE

cd $PKGDIR

./configure --prefix=/usr   \
            --enable-shared \
            --disable-static &&
make

make install

cd ..

rm -rf $PKGDIR

rm $FILE

popd

unset FILE PKGDIR
