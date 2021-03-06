#!/tools/bin/bash -e

trap 'echo zlib; times' EXIT

source try_unpack.bash

export PKGDIR="zlib-1.2.8"

trap 'echo '$PKGDIR'; times' EXIT

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR
CFLAGS="-march=native -pipe -O2 -fstack-protector-strong" \
CXXFLAGS="-march=native -pipe -O2 -fstack-protector-strong" \
./configure --prefix=/usr

make

make install

mv -v /usr/lib/libz.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libz.so) /usr/lib/libz.so

cd ..

rm -rf $PKGDIR

popd

unset  PKGNAME
