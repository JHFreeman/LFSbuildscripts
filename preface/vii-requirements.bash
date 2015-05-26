#!/bin/bash -e


if [ ! -e /bin/bash ]; then
	yum -y install bash
fi

if [ -e /bin/sh ]; then
	rm /bin/sh
fi

ln -sv bash /bin/sh

if [ ! -e /usr/bison ]; then
	yum -y install bison
fi

if [ -e /usr/bin/yacc ]; then
	rm /usr/bin/yacc
fi

ln -sv bison /usr/bin/yacc

yum -y install texinfo

yum -y install gcc gcc-c++ bzip2 patch