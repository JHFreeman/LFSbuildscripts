#!/bin/bash -e

source try_unpack.bash

export PKGDIR="inetutils-1.9.3"

trap 'echo '$PKGDIR'; times' EXIT

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

echo '#define PATH_PROCNET_DEV "/proc/net/dev"' >> ifconfig/system/linux.h 

CFLAGS="-march=native -pipe -O2 -fstack-protector-strong" \
CXXFLAGS="-march=native -pipe -O2 -fstack-protector-strong" \
./configure --prefix=/usr        \
            --localstatedir=/var \
            --disable-logger     \
            --disable-whois      \
            --disable-servers
            
make

make install

mv -v /usr/bin/{hostname,ping,ping6,traceroute} /bin
mv -v /usr/bin/ifconfig /sbin

cd ..
rm -rf $PKGDIR
popd
unset  PKGDIR CFLAGS CXXFLAGS
