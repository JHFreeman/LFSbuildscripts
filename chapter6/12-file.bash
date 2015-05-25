#!/tools/bin/bash -e

source try_unpack.bash



export PKGDIR="file-5.22"

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

./configure --prefix=/usr

make

make install

cd ..

rm -rf $PKGDIR

popd

unset  PKGDIR
echo "./12-file.sh ran"
