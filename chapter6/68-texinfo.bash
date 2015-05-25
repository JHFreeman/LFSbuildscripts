#!/bin/bash -e

source try_unpack.bash



export PKGDIR="texinfo-5.2"

pushd /sources

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
popd
unset  PKGDIR
echo "./68-texinfo.sh ran"
./69-vim.sh