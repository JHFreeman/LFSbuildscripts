#!/tools/bin/bash -e

source try_unpack.bash


pushd /sources

export PKGDIR="linux-4.0.3"

try_unpack $PKGDIR

cd $PKGDIR

make mrproper

make INSTALL_HDR_PATH=dest headers_install
find dest/include \( -name .install -o -name ..install.cmd \) -delete
cp -rv dest/include/* /usr/include

cd ..

rm -rf $PKGDIR

echo "$PKGDIR"

popd

unset  PKGDIR
echo "./7-api-headers.sh ran"
