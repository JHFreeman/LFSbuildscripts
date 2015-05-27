#!/bin/bash -e

trap 'echo lfs; times' EXIT

source preface/vii-requirements.bash

source chapter2/00-build.bash

source chapter3/00-build.bash

source chapter4/00-build.bash

source chapter5/00-build.bash

source chapter6/00-build.bash

source chapter7/00-build.bash

source chapter9/00-build.bash

