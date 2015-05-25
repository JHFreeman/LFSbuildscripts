#!/bin/bash -e

source ../get_dir.sh

export URL="http://www.cmake.org/files/v3.1/cmake-3.1.3.tar.gz"
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

./bootstrap --prefix=/usr       \
            --system-libs       \
            --mandir=/share/man \
            --docdir=/share/doc/cmake-3.1.3 &&
make

make install

cd ..

rm -rf $PKGDIR

rm $FILE

popd

unset FILE PKGDIR URL