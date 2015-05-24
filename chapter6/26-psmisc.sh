#!/tools/bin/bash -e

source try_unpack.sh

export PREV_DIR=$PWD

export PKGDIR="psmisc-22.21"

cd /sources

try_unpack $PKGDIR

cd $PKGDIR

./configure --prefix=/usr

make

make install

mv -v /usr/bin/fuser /bin
mv -v /usr/bin/killall /bin

cd ..
rm -rf $PKGDIR
cd $PREV_DIR
unset PREV_DIR PKGDIR
echo "./26-psmisc.sh ran"
