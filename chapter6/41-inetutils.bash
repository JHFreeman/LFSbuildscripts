#!/bin/bash -e

source try_unpack.bash



export PKGDIR="inetutils-1.9.2"

pushd /sources

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
popd
unset  PKGDIR
echo "./41-inetutils.sh ran"
source 42-perl.sh