#!/bin/bash
set -x

cmd="cd /content && python3 -m mkdocs serve"
#cmd='/bin/bash'

docker run -it --rm \
  --mount "type=bind,src=`pwd`/test/content,dst=/content" \
  --mount "type=bind,src=`pwd`/stage,dst=/stage" \
  --publish 8888:8000 \
  mkdocs_build /bin/bash -c "$cmd"
#  stevegroom/mkdocs_build $cmd