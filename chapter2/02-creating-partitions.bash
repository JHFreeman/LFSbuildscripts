#!/bin/bash

(echo n; echo p; echo 1; echo ; echo +60G; \
echo n; echo e; echo 2; echo ; echo; \
echo n; echo l; echo 5; echo ; echo; \
echo t; echo 5; echo 82; \
echo w) | fdisk /dev/sdb