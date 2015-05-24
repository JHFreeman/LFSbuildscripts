#!/tools/bin/bash -e

source try_unpack.sh

export PREV_DIR=$PWD

export PKGDIR="libcap-2.24"

cd /sources

try_unpack $PKGDIR

cd $PKGDIR

make

make RAISE_SETFCAP=no prefix=/usr install
chmod -v 755 /usr/lib/libcap.so

mv -v /usr/lib/libcap.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libcap.so) /usr/lib/libcap.so

cd ..
rm -rf $PKGDIR

cd $PREV_DIR

unset PREV_DIR PKGDIR
echo "./23-libcap.sh ran"
