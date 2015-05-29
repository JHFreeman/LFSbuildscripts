#!/bin/bash -e

source try_unpack.bash

pushd /sources

export PKGDIR="wget-1.16.3"

export CFLAGS="-march=native -pipe -O2 -fstack-protector-strong"
export CXXFLAGS="-march=native -pipe -O2 -fstack-protector-strong"
trap 'echo '$PKGDIR'; times' EXIT

if [ -d $PKGDIR ]; then
	rm -rf $PKGDIR
fi

try_unpack $PKGDIR

cd $PKGDIR

./configure --prefix=/usr      \
            --sysconfdir=/etc  \
            --with-ssl=openssl &&
make

make install

echo ca-directory=/etc/ssl/certs >> /etc/wgetrc

cd ..

rm -rf $PKGDIR

popd