#!/bin/bash -e

trap times && echo ":chapter8" EXIT

source 02-fstab.bash
source 03-kernel.bash
source 04-grub.bash
