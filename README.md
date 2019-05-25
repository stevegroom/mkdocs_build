# mkdocs_build
dockerfile to run mkdocs build command

To mount the required external directories and build the content

```bash
docker run -it \
  --mount 'type=bind,src=/Users/steve/development/docker/mkdocstest/content,dst=/content' \
  --mount 'type=bind,src=/Users/steve/development/docker/mkdocstest/stage,dst=/stage' \
  stevegroom/mkdocs_build
```

If you have any issue, then add ```/bin/bash``` to replace the built in ```RUN cd /content && python3 -m mkdocs build```

```bash
docker run -it \
  --mount 'type=bind,src=/Users/steve/development/docker/mkdocstest/content,dst=/content' \
  --mount 'type=bind,src=/Users/steve/development/docker/mkdocstest/stage,dst=/stage' \
  stevegroom/mkdocs_build /bin/bash
```
