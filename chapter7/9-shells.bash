#!/bin/bash -e

if [ ! -e /etc/shells ]; then
cat > /etc/shells << "EOF"
# Begin /etc/shells

/bin/sh
/bin/bash

# End /etc/shells
EOF
fi

pushd ../chapter8

source 2-fstab.sh

popd