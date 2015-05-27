#!/bin/bash -e


if [ ! -z $1 ]; then
	stage=$1
	trap times && echo "chapter4:Stage:$stage" EXIT
fi

if [[ -z $1 ]]; then
	source 02-creating.bash
	source 03-adding.bash
elif [[ $((stage)) -eq 2 ]]; then
	source 04-environment.bash
	source 05+mountsharedfolder.bash
fi
