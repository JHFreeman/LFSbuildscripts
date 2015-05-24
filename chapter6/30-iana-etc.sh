#!/tools/bin/bash -e

source try_unpack.sh

export PREV_DIR=$PWD

export PKGDIR="iana-etc-2.30"

cd /sources

try_unpack $PKGDIR

cd $PKGDIR

make

make install

cd ..
rm -rf $PKGDIR
cd $PREV_DIR
unset PREV_DIR PKGDIR
echo "./30-iana-etc.sh ran"
