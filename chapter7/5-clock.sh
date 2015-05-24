#!/bin/bash -e

cat > /etc/adjtime << "EOF"
0.0 0 0.0
0
LOCAL
EOF

