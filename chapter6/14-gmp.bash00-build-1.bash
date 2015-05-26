#!/tools/bin/bash -e

source try_unpack.bash



export PKGDIR="gmp-6.0.0"

pushd /sources

try_unpack $PKGDIR"a"

cd $PKGDIR

./configure --prefix=/usr \
            --enable-cxx  \
            --docdir=/usr/share/doc/gmp-6.0.0a
                           
make
make html

make install
make install-html

cd ..

rm -rf $PKGDIR

popd

unset  PKGDIR

echo "./14-gmp.sh ran"
