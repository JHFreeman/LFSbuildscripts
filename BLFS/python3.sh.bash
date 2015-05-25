#!/bin/bash -e

source get_dir.sh
export URL="http://www.python.org/ftp/python/3.4.2/Python-3.4.2.tar.xz"
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

./configure --prefix=/usr       \
            --enable-shared     \
            --with-system-expat \
            --with-system-ffi   \
            --without-ensurepip &&
make

make install &&
chmod -v 755 /usr/lib/libpython3.4m.so &&
chmod -v 755 /usr/lib/libpython3.so

cd ..

rm -rf $PKGDIR

popd

unset URL FILE PKGDIR