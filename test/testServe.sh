#!/bin/bash

set -x

cmd='/bin/sh -c cd /content && python3 -m mkdocs serve'
#cmd='/bin/bash'

docker run -d \
  --mount "type=bind,src=`pwd`/test/content,dst=/content" \
  --mount "type=bind,src=`pwd`/stage,dst=/stage" \
  -p 801:80 \
  mkdocs_build $cmd
#  stevegroom/mkdocs_build $cmd