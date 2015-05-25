#!/bin/bash -e

as_root()
{
	if	[ $EUID = 0 ];	then $*
	elif	[ -x /usr/bin/sudo ];	then sudo $*
	fi
}

export -f as_root
