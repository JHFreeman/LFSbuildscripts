#!/bin/bash -e

source try_unpack.bash



export PKGDIR="perl-5.20.2"

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

echo "127.0.0.1 localhost $(hostname)" > /etc/hosts

export BUILD_ZLIB=False
export BUILD_BZIP2=0

sh Configure -des -Dprefix=/usr                 \
                  -Dvendorprefix=/usr           \
                  -Dman1dir=/usr/share/man/man1 \
                  -Dman3dir=/usr/share/man/man3 \
                  -Dpager="/usr/bin/less -isR"  \
                  -Duseshrplib
                  
make

make install
unset BUILD_ZLIB BUILD_BZIP2
cd ..
rm -rf $PKGDIR
popd
unset  PKGDIR
echo "./42-perl.sh ran"
source 43-XML-Parser.sh
