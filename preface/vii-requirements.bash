#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

source $DIR/as_root.sh

if [ ! -e /bin/bash ]; then
	as_root apt-get -y install bash
fi

if [ -e /bin/sh ]; then
	as_root rm /bin/sh
fi

as_root ln -sv bash /bin/sh

if [ ! -e /usr/bin/bison ]; then
	as_root apt-get -y install bison
fi

if [ -e /usr/bin/yacc ]; then
	as_root rm /usr/bin/yacc
fi

as_root ln -sv bison /usr/bin/yacc

as_root apt-get -y install texinfo

as_root apt-get -y install build-essential