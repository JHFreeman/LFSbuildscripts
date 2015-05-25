#!/bin/bash

source as_root.bash

as_root mkfs -v -t ext4 /dev/sdb1

as_root mkswap /dev/sdb5
