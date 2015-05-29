#!/bin/bash -e

trap 'echo chapter9; times' EXIT

export CFLAGS="-march=native -pipe -O2 -fstack-protector-strong"
export CXXFLAGS="-march=native -pipe -O2 -fstack-protector-strong"

source 01-the-end.bash

#from BLFS

source 99-gpm.bash
source 99-dhcp.bash
source 99-openssl.bash
source 99-wget.bash
source 99-openssh.bash

unset CFLAGS CXXFLAGS