#!/tools/bin/bash -e

source try_unpack.bash



export PKGDIR="mpc-1.0.2"

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

./configure --prefix=/usr --docdir=/usr/share/doc/mpc-1.0.2
                           
make
make html

make install
make install-html

cd ..

rm -rf $PKGDIR

popd

unset  PKGDIR
echo "./16-mpc.sh ran"
