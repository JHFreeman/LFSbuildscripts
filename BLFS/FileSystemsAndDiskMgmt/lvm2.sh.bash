#!/bin/bash -e

source ../get_dir.sh
URL="ftp://sources.redhat.com/pub/lvm2/LVM2.2.02.116.tgz"
FILE=${URL##*/}

pushd /sources

if [ -e $FILE ]; then
	rm $FILE
fi

wget $URL

PKGDIR=$(get_dir ${FILE})

if [ -d $PKGDIR]; then
	rm -rf $PKGDIR
fi

tar -xf ${FILE}

cd $PKGDIR

./configure --prefix=/usr       \
            --exec-prefix=      \
            --with-confdir=/etc \
            --enable-applib     \
            --enable-cmdlib     \
            --enable-pkgconfig  \
            --enable-udev_sync  &&
make

make install

cd ..

rm -rf $PKGDIR $FILE

popd
