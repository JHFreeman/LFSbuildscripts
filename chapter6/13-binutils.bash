#!/tools/bin/bash -e

source try_unpack.bash

export PKGNAME="binutils"
export PKGDIR="binutils-2.25"

trap 'echo '$PKGDIR'; times' EXIT

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

mkdir ../$PKGNAME-build
cd ../$PKGNAME-build

CFLAGS="-march=native -pipe -O2 -fstack-protector-strong" \
CXXFLAGS="-march=native -pipe -O2 -fstack-protector-strong" \
../$PKGDIR/configure --prefix=/usr   \
                           --enable-shared \
                           --disable-werror
                           
make tooldir=/usr

make tooldir=/usr install

cd ..

rm -rf $PKGDIR $PKGNAME-build

popd

unset  PKGDIR PKGNAME

