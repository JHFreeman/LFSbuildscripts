#!/bin/bash -e

if [ ! -e /etc/os-release ]; then
cat > /etc/os-release << "EOF"
NAME="Linux From Scratch"
VERSION="7.7-systemd"
ID=lfs
PRETTY_NAME="Linux From Scratch 7.7-systemd"
EOF
fi

if [ ! -e /etc/lfs-release ]; then
echo 7.7-systemd > /etc/lfs-release
fi

if [ ! -e /etc/lsb-release ]; then
cat > /etc/lsb-release << "EOF"
DISTRIB_ID="Linux From Scratch"
DISTRIB_RELEASE="7.7-systemd"
DISTRIB_CODENAME="seeit"
DISTRIB_DESCRIPTION="Linux From Scratch"
EOF
fi
