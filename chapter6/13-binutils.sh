#!/tools/bin/bash -e

source try_unpack.sh

export PREV_DIR=$PWD

export PKGNAME="binutils"
export PKGDIR="binutils-2.25"

cd /sources

try_unpack $PKGDIR

cd $PKGDIR

mkdir ../$PKGNAME-build
cd ../$PKGNAME-build

../$PKGDIR/configure --prefix=/usr   \
                           --enable-shared \
                           --disable-werror
                           
make tooldir=/usr

make tooldir=/usr install

cd ..

rm -rf $PKGDIR $PKGNAME-build

cd $PREV_DIR

unset PREV_DIR PKGDIR PKGNAME
echo "./13-binutils.sh ran"
