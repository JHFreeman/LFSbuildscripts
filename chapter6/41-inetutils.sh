#!/bin/bash

source try_unpack.sh

export PREV_DIR=$PWD

export PKGDIR="inetutils-1.9.2"

cd /sources

try_unpack $PKGDIR

cd $PKGDIR

echo '#define PATH_PROCNET_DEV "/proc/net/dev"' >> ifconfig/system/linux.h 

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
cd $PREV_DIR
unset PREV_DIR PKGDIR
echo "./41-inetutils.sh ran"
