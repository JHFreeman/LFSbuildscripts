#!/tools/bin/bash -e

source try_unpack.bash



export PKGDIR="pkg-config-0.28"

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

./configure --prefix=/usr        \
            --with-internal-glib \
            --disable-host-tool  \
            --docdir=/usr/share/doc/pkg-config-0.28
            
make

make install

cd ..

rm -rf $PKGDIR

popd

unset  PKGNAME
echo "./19-pkg-config.sh ran"
