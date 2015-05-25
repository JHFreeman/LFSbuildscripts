#!/bin/bash -e
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

$DIR/02-creating-partitions

$DIR/03-filesystem

$DIR/04-mount

