#!/bin/bash -e

if [ ! -e /etc/systemd/network/10-dhcp-eth.network ]; then
cat > /etc/systemd/network/10-dhcp-eth0.network << "EOF"
[Match]
Name=enp5s0

[Network]
DHCP=yes
EOF
fi

if [ ! -e /etc/resolv.conf ]; then
pushd ../configfiles/
cp resolv.conf /etc
popd
fi

if [ ! -e /etc/hostname ]; then
	echo "freeman" > /etc/hostname
fi

if [ ! -e /etc/hosts ]; then
cat > /etc/hosts << "EOF"
# Begin /etc/hosts (network card version)

127.0.0.1 localhost
::1       localhost

# End /etc/hosts (network card version)
EOF
fi

source 5-clock.sh