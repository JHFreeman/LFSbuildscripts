#!/bin/bash

source try_unpack.sh

export PREV_DIR=$PWD

export PKGDIR="texinfo-5.2"

cd /sources

try_unpack $PKGDIR

cd $PKGDIR

./configure --prefix=/usr

make

make install

make TEXMF=/usr/share/texmf install-tex

pushd /usr/share/info
rm -v dir
for f in *
  do install-info $f dir 2>/dev/null
done
popd

cd ..
rm -rf $PKGDIR
cd $PREV_DIR
unset PREV_DIR PKGDIR
echo "./68-texinfo.sh ran"
