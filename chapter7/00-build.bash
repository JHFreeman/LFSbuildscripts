#!/bin/bash -e

trap 'echo chapter 7; times' EXIT

export CFLAGS="-march=native -pipe -O2 -fstack-protector-strong"
export CXXFLAGS="-march=native -pipe -O2 -fstack-protector-strong"
source 02-network.bash
source 05-clock.bash
source 08-inputrc.bash
source 09-shells.bash
unset CFLAGS CXXFLAGS