#!/bin/bash
set -x

docker run -it --rm \
  --mount "type=bind,src=`pwd`/test/content,dst=/content" \
  --mount "type=bind,src=`pwd`/stage,dst=/stage" \
  mkdocs_build
#  stevegroom/mkdocs_build