#!/bin/bash -e

source ../get_dir.sh
URL="http://www.hboehm.info/gc/gc_source/gc-7.4.2.tar.gz"
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

sed -i 's#pkgdata#doc#' doc/doc.am &&
autoreconf -fi  &&
./configure --prefix=/usr      \
            --enable-cplusplus \
            --disable-static   \
            --docdir=/usr/share/doc/gc-7.4.2 &&
make

make install &&
install -v -m644 doc/gc.man /usr/share/man/man3/gc_malloc.3 &&
ln -sfv gc_malloc.3 /usr/share/man/man3/gc.3 

cd ..

rm -rf $PKGDIR

rm $FILE

popd

unset FILE PKGDIR URL