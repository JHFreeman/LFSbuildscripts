#!/bin/bash -e

trap 'echo chapter8; times' EXIT

source 02-fstab.bash
source 03-kernel.bash
source 04-grub.bash
