#!/tools/bin/bash -e

source try_unpack.sh

export PREV_DIR=$PWD

export PKGDIR="zlib-1.2.8"

cd /sources

try_unpack $PKGDIR

cd $PKGDIR

./configure --prefix=/usr

make

make install

mv -v /usr/lib/libz.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libz.so) /usr/lib/libz.so

cd ..

rm -rf $PKGDIR

cd $PREV_DIR

unset PREV_DIR PKGNAME
echo "./11-zlib.sh ran"
