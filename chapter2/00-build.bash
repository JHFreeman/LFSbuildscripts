#!/bin/bash -e

trap times && echo ":chapter2" EXIT

source 02-creating-partitions.bash

source 03-filesystem.bash

source 04-mount.bash

