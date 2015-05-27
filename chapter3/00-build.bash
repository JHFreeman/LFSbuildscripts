#!/bin/bash -e

trap 'echo chapter3; times' EXIT

source 01-introduction.bash

source 02+additionalpackages.bash