#!/bin/bash -e

source ../get_dir.sh
URL="http://www.ivmaisoft.com/_bin/atomic_ops//libatomic_ops-7.4.2.tar.gz"
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

sed -i 's#pkgdata#doc#' doc/Makefile.am Makefile.am &&
autoreconf -fi &&
./configure --prefix=/usr    \
            --enable-shared  \
            --disable-static \
            --docdir=/usr/share/doc/libatomic_ops-7.4.2 &&
make

make install

cd ..

rm -rf $PKGDIR

rm $FILE

popd

unset FILE PKGDIR URL