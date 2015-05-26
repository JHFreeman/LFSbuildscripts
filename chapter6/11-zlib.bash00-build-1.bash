#!/tools/bin/bash -e

source try_unpack.bash



export PKGDIR="zlib-1.2.8"

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

./configure --prefix=/usr

make

make install

mv -v /usr/lib/libz.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libz.so) /usr/lib/libz.so

cd ..

rm -rf $PKGDIR

popd

unset  PKGNAME
echo "./11-zlib.sh ran"
