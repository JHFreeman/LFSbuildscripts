#!/bin/bash -e

source try_unpack.bash



export PKGDIR="gzip-1.6"

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

./configure --prefix=/usr --bindir=/bin

make

make install

mv -v /bin/{gzexe,uncompress,zcmp,zdiff,zegrep} /usr/bin
mv -v /bin/{zfgrep,zforce,zgrep,zless,zmore,znew} /usr/bin

cd ..
rm -rf $PKGDIR
popd
unset  PKGDIR
echo "./56-gzip.sh ran"
source 57-iproute.sh
