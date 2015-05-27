#!/bin/bash

mkfs -v -t ext4 /dev/sdb1

mkswap /dev/sdb5
