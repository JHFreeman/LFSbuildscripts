#!/bin/bash -e

stage=$1

if [[ $((stage)) -eq 1 ]]; then
	source 02-preparing.bash
	source 04-enter-chroot.bash
else
	echo "Please specify a valid stage of the build to process"
fi


