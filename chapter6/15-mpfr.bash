#!/tools/bin/bash -e

source try_unpack.bash

export PKGDIR="mpfr-3.1.2"

trap 'echo '$PKGDIR'; times' EXIT

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

patch -Np1 -i ../mpfr-3.1.2-upstream_fixes-3.patch

CFLAGS="-march=native -pipe -O2 -fstack-protector-strong" \
CXXFLAGS="-march=native -pipe -O2 -fstack-protector-strong" \
./configure --prefix=/usr \
            --enable-thread-safe  \
            --docdir=/usr/share/doc/mpfr-3.1.2
                           
make
make html

make install
make install-html

cd ..

rm -rf $PKGDIR

popd

unset  PKGDIR
