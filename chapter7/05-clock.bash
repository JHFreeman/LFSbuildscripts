#!/bin/bash -e

if [ ! -e /etc/adjtime ]; then
cat > /etc/adjtime << "EOF"
0.0 0 0.0
0
LOCAL
EOF
fi
