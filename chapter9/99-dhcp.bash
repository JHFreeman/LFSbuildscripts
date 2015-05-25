#!/bin/bash

export PKGDIR="dhcp-4.3.1"

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

patch -Np1 -i ../dhcp-4.3.1-client_script-1.patch &&
CFLAGS="-D_PATH_DHCLIENT_SCRIPT='\"/sbin/dhclient-script\"'         \
        -D_PATH_DHCPD_CONF='\"/etc/dhcp/dhcpd.conf\"'               \
        -D_PATH_DHCLIENT_CONF='\"/etc/dhcp/dhclient.conf\"'"        \
./configure --prefix=/usr                                           \
            --sysconfdir=/etc/dhcp                                  \
            --localstatedir=/var                                    \
            --with-srv-lease-file=/var/lib/dhcpd/dhcpd.leases       \
            --with-srv6-lease-file=/var/lib/dhcpd/dhcpd6.leases     \
            --with-cli-lease-file=/var/lib/dhclient/dhclient.leases \
            --with-cli6-lease-file=/var/lib/dhclient/dhclient6.leases &&
make

make -C client install         &&
mv -v /usr/sbin/dhclient /sbin &&
install -v -m755 client/scripts/linux /sbin/dhclient-script

if [ ! -e /etc/dhcp/dhclient.conf ];
cat > /etc/dhcp/dhclient.conf << "EOF"
# Begin /etc/dhcp/dhclient.conf
#
# Basic dhclient.conf(5)

#prepend domain-name-servers 127.0.0.1;
request subnet-mask, broadcast-address, time-offset, routers,
        domain-name, domain-name-servers, domain-search, host-name,
        netbios-name-servers, netbios-scope, interface-mtu,
        ntp-servers;
require subnet-mask, domain-name-servers;
#timeout 60;
#retry 60;
#reboot 10;
#select-timeout 5;
#initial-interval 2;

# End /etc/dhcp/dhclient.conf
EOF
fi

if [ ! -d /var/lib/dhclient ]; then
install -v -dm 755 /var/lib/dhclient
fi

cd ..

rm -rf $PKGDIR

pushd blfs-systemd-units-20150210

make install-dhclient

popd