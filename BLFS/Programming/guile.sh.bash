#!/bin/bash -e

source ../get_dir.sh
URL="http://ftp.gnu.org/pub/gnu/guile/guile-2.0.11.tar.xz"
FILE=${URL##*/}

pushd /sources

if [ -e $FILE ]; then
	rm $FILE
fi

wget $URL

PKGDIR=$(get_dir $FILE)

if [ -d $PKGDIR ]; then
	rm -rf $PKGDIR
fi

tar -xf ${FILE}

cd $PKGDIR

./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/guile-2.0.11 &&
make

make install

if [ ! -d /usr/share/gdb/auto-load/usr/lib ]; then
	mkdir -pv /usr/share/gdb/auto-load/usr/lib
fi

mv /usr/lib/libguile-*-gdb.scm /usr/share/gdb/auto-load/usr/lib

cd ..

rm -rf $PKGDIR

rm $FILE

popd

unset FILE PKGDIR URL