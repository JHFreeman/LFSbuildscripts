#!/bin/bash

export LFS=/mnt/lfs

source as_root.bash 

source try_unpack.bash

pushd $PWD/chapter5

source 1-binutils-pass-1.sh

# begin gcc pass #1

source 2-gcc-pass-1.sh

# end gcc pass #1
# Linux api headers

source 3-linux-headers.sh

# end Linux api headers

# Begin glibc

source 4-glibc.sh

# end glibc

# begin libstdc++

source 5-libstdcplusplus.sh

# end libstdc++

# begin binutils pass #2

source 6-binutils-pass-2.sh

# end binutils pass #2

# begin gcc pass #2

source 7-gcc-pass-2.sh

# end gcc pass #2

# begin tcl

source 8-tcl.sh

# end tcl

# begin expect

source 9-expect.sh

# end expect

# begin dejagnu

source 10-dejagnu.sh

# end dejagnu

# begin check

source 11-check.sh

# end check

# begin ncurses

source 12-ncurses.sh

# end ncurses

# begin bash

source 13-bash.sh

# end bash

# begin bzip2

source 14-bzip2.sh

# end bzip2

# begin coreutils

source 15-coreutils.sh

# end coreutils

# begin diffutils

source 16-diffutils.sh

# end diffutils

# begin file-5.22

source 17-file.sh

# end file

# begin findutils-4.4.2

source 18-findutils.sh

# end fileutils

# being gawk-4.1.1

source 19-gawk.sh

# end gawk

# begin gettext-0.19.4

source 20-gettext.sh

# end gettext

# begin grep-2.21

source 21-grep.sh

# end grep

# begin gzip-1.6

source 22-gzip.sh

# end gzip

# begin m4-1.4.17

source 23-m4.sh

# end m4

# begin make-4.1

source 24-make.sh

# end make

# begin patch-2.7.4

source 25-patch.sh

# end patch

# begin perl-5.20.2

source 26-perl.sh

# end perl

# begin sed-4.2.2

source 27-sed.sh

# end sed

# begin tar-1.28

source 28-tar.sh

# end tar

# begin texinfo-5.2

source 29-texinfo.sh

# end texinfo

# begin util-linux-2.26

source 30-util-linux.sh

# end util-linux

# begin xz-5.2.0

source 31-xz.sh

# end xz-5.2.0

# begin cleanup

source 32-strip.sh

#end cleanup

popd