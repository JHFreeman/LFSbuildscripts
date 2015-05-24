#!/bin/bash -e

cat > /etc/systemd/network/10-dhcp-eth0.network << "EOF"
[Match]
Name=enp5s0

[Network]
DHCP=yes
EOF

cat > /etc/resolv.conf << "EOF"
# Begin /etc/resolv.conf

domain brainkernel.com
nameserver 8.8.8.8
nameserver 8.8.4.4

# End /etc/resolv.conf
EOF

ln -sfv /run/systemd/resolve/resolv.conf /etc/resolv.conf

echo "freeman" > /etc/hostname

cat > /etc/hosts << "EOF"
# Begin /etc/hosts (network card version)

127.0.0.1 localhost
::1       localhost

# End /etc/hosts (network card version)
EOF
