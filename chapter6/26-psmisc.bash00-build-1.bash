#!/tools/bin/bash -e

source try_unpack.bash



export PKGDIR="psmisc-22.21"

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

./configure --prefix=/usr

make

make install

mv -v /usr/bin/fuser /bin
mv -v /usr/bin/killall /bin

cd ..
rm -rf $PKGDIR
popd
unset  PKGDIR
echo "./26-psmisc.sh ran"
