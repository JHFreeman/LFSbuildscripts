#!/tools/bin/bash -e

source try_unpack.bash

export PKGDIR="pkg-config-0.28"

trap 'echo '$PKGDIR'; times' EXIT

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

CFLAGS="-march=native -pipe -O2 -fstack-protector-strong" \
CXXFLAGS="-march=native -pipe -O2 -fstack-protector-strong" \
./configure --prefix=/usr        \
            --with-internal-glib \
            --disable-host-tool  \
            --docdir=/usr/share/doc/pkg-config-0.28
            
make

make install

cd ..

rm -rf $PKGDIR

popd

unset  PKGNAME
