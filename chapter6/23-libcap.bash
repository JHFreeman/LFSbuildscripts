#!/tools/bin/bash -e

source try_unpack.bash



export PKGDIR="libcap-2.24"

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

make

make RAISE_SETFCAP=no prefix=/usr install
chmod -v 755 /usr/lib/libcap.so

mv -v /usr/lib/libcap.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libcap.so) /usr/lib/libcap.so

cd ..
rm -rf $PKGDIR

popd

unset  PKGDIR
echo "./23-libcap.sh ran"
