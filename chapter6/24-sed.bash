#!/tools/bin/bash -e

source try_unpack.bash



export PKGDIR="sed-4.2.2"

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

./configure --prefix=/usr --bindir=/bin --htmldir=/usr/share/doc/sed-4.2.2

make
make html

make install
make -C doc install-html

cd ..

rm -rf $PKGDIR

popd

unset  PKGDIR
echo "./24-sed.sh ran"
