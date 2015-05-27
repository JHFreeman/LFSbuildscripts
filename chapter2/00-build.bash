#!/bin/bash -e

trap 'echo chapter2; times' EXIT

source 02-creating-partitions.bash

source 03-filesystem.bash

source 04-mount.bash

