#!/bin/bash -e

export MAKEFLAGS='-j '$(($(nproc)+1))
