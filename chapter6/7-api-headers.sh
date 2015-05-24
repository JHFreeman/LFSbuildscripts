#!/tools/bin/bash -e

source try_unpack.sh

export PREV_DIR=$PWD
cd /sources

export PKGDIR="linux-3.19"

try_unpack $PKGDIR

cd $PKGDIR

make mrproper

make INSTALL_HDR_PATH=dest headers_install
find dest/include \( -name .install -o -name ..install.cmd \) -delete
cp -rv dest/include/* /usr/include

cd ..

rm -rf $PKGDIR

echo "$PKGDIR"

cd $PREV_DIR

unset PREV_DIR PKGDIR
echo "./7-api-headers.sh ran"
