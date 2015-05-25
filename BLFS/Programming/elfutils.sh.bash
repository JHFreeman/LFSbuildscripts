#!/bin/bash

source ../get_dir.sh
URL="https://fedorahosted.org/releases/e/l/elfutils/0.161/elfutils-0.161.tar.bz2"
FILE=${URL##*/}

pushd /sources

if [ -e $FILE ]; then
	rm $FILE
fi

wget $URL

PKGDIR=$(get_dir ${FILE})

if [ -e $PKGDIR ]; then
	rm -rf $PKGDIR
fi

tar -xf ${FILE}

cd ${PKGDIR}

./configure --prefix=/usr --program-prefix="eu-" &&
make

make install

cd ..

rm -rf $PKGDIR

rm $FILE

popd

unset FILE PKGDIR URL