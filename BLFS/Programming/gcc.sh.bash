#!/bin/bash

source ../get_dir.sh
URL="http://ftp.gnu.org/gnu/gcc/gcc-4.9.2/gcc-4.9.2.tar.bz2"
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

if [ -d "gcc-build" ]; then
	rm -rf "gcc-build"
fi


tar -xf ${FILE}

cd $PKGDIR

mkdir ../gcc-build                                   &&
cd    ../gcc-build                                   &&

../gcc-4.9.2/configure                               \
    --prefix=/usr                                    \
    --disable-multilib                               \
    --with-system-zlib                               \
    --enable-languages=c,c++,fortran,go,objc,obj-c++ &&
make

make install &&

mkdir -pv /usr/share/gdb/auto-load/usr/lib              &&
mv -v /usr/lib/*gdb.py /usr/share/gdb/auto-load/usr/lib &&

chown -v -R root:root \
    /usr/lib/gcc/*linux-gnu/4.9.2/include{,-fixed}
    
if [ -h /lib/cpp ]; then
	rm /lib/cpp
fi
ln -sfv ../usr/bin/cpp /lib &&

if [ -h /usr/bin/cc ]; then
	ln -sfv gcc /usr/bin/cc
fi

cd ..

rm -rf $PKGDIR gcc-build

rm $FILE

popd

unset PKGDIR FILE URL
