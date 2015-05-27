#!/bin/bash -e

if [ ! -e /etc/fstab ]; then
cat > /etc/fstab << "EOF"
# Begin /etc/fstab

# file system  mount-point  type     options             dump  fsck
#                                                              order

/dev/sda1     /            ext4    defaults            1     1
/dev/sda5     swap         swap     pri=1               0     0

# End /etc/fstab
EOF
fi
./3-kernel.sh