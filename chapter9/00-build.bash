#!/bin/bash -e

trap 'echo chapter9; times' EXIT

source 01-the-end.bash

#from BLFS

source 99-gpm.bash
source 99-dhcp.bash
source 99-openssl.bash
source 99-wget.bash
source 99-openssh.bash