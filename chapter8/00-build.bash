#!/bin/bash -e

trap 'echo chapter8; times' EXIT

export CFLAGS="-march=native -pipe -O2 -fstack-protector-strong"
export CXXFLAGS="-march=native -pipe -O2 -fstack-protector-strong"
source 02-fstab.bash
source 03-kernel.bash
source 04-grub.bash
unset CFLAGS CXXFLAGS