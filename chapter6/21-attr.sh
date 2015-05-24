#!/tools/bin/bash -e

source try_unpack.sh

export PREV_DIR=$PWD

export PKGDIR="attr-2.4.47"

cd /sources

try_unpack $PKGDIR

cd $PKGDIR

sed -i -e 's|/@pkg_name@|&-@pkg_version@|' include/builddefs.in

sed -i -e "/SUBDIRS/s|man2||" man/Makefile

./configure --prefix=/usr

make
make install install-dev install-lib
chmod -v 755 /usr/lib/libattr.so

mv -v /usr/lib/libattr.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libattr.so) /usr/lib/libattr.so

cd ..

rm -rf $PKGDIR

cd $PREV_DIR

unset PREV_DIR PKGDIR
echo "./21-attr.sh ran"
