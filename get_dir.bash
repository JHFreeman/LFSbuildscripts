#!/bin/bash -e

get_dir()
{
	echo "$(tar -tf $1 | grep -o '^[^/]\+' | sort -u)"
}

export -f get_dir