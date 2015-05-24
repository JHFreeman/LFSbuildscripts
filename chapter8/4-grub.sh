#!/bin/bash -e

grub-install /dev/sda

cat > /boot/grub/grub.cfg << "EOF"
# Begin /boot/grub/grub.cfg
set default=0
set timeout=5

insmod ext2
set root=(hd0,1)

menuentry "GNU/Linux, Linux 3.19-lfs-7.7-systemd" {
        linux   /boot/vmlinuz-3.19-lfs-7.7-systemd root=/dev/sda1 ro
}
EOF

