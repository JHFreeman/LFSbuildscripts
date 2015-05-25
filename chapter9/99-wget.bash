#!/bin/bash

pushd /sources

export PKGDIR="wget-1.16.1"

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