#!/tools/bin/bash -e

source try_unpack.bash

export PKGDIR="attr-2.4.47"

trap 'echo '$PKGDIR'; times' EXIT

pushd /sources

try_unpack $PKGDIR.src

cd $PKGDIR

sed -i -e 's|/@pkg_name@|&-@pkg_version@|' include/builddefs.in

sed -i -e "/SUBDIRS/s|man2||" man/Makefile

CFLAGS="-march=native -pipe -O2 -fstack-protector-strong" \
CXXFLAGS="-march=native -pipe -O2 -fstack-protector-strong" \
./configure --prefix=/usr

make
make install install-dev install-lib
chmod -v 755 /usr/lib/libattr.so

mv -v /usr/lib/libattr.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libattr.so) /usr/lib/libattr.so

cd ..

rm -rf $PKGDIR

popd

unset  PKGDIR
