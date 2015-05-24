#!/tools/bin/bash -e

source try_unpack.sh

pushd $PWD/chapter6

source 7-api-headers.sh

source 8-man-pages.sh

source 9-glibc.sh

source 10-adjusting.sh

source 11-zlib.sh

source 12-file.sh

source 13-binutils.sh

source 14-gmp.sh

source 15-mpfr.sh

source 16-mpc.sh

source 17-gcc.sh

source 18-bzip2.sh

popd