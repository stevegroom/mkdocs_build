# stevegroom/mkdocs_build:latest

Dockerfile to run mkdocs build command

## Usage

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

## Design

This Dockerfile creates the environment to support mkdocs with a number of extensions.

## Dockerfile

```docker
# Mkdocs service

FROM ubuntu:19.10

LABEL maintainer="Steve.Groom@nestle.com"
LABEL version="0.1"
LABEL description="This dockerfile \
installs python and c modules needed \
to run mkdocs with several extensions."
```

The base image is ubuntu 19 - to work well in Azure DevOps pipelines, ```Ubuntu``` is a good choice and ```bash``` is a requirement.
I selected version 19 in an attempt to get a Linux that was compatible with recent builds of libcairo - the standard ubuntu 16.09 build
from the Azure Pipeline would not upgrade libcairo to a version required by ```pandocs```.

```docker
VOLUME /content
VOLUME /stage
```

The ```VOLUME``` statements here are not (yet) properly understood - they may not be needed. However the repo needs to have the content
to compile.

repo  
  /content  
    /docs  
      &lt;all the source is stored here>  
    mkdocs.yml
..  
  /app
    /backend
      /public
        &lt;generated site stored here>

```docker
RUN apt-get clean
RUN rm -r  /var/lib/apt/lists/*
RUN apt-get update
```

Clean the apt environment. Without this ```libcairo``` can't be updated.

```docker
RUN apt-get --assume-yes install libcairo2  \
    libcairo2-dev \
    build-essential \
    python3-dev \
    python3-pip \
    python3-setuptools \
    python3-wheel \
    python3-cffi \
    libcairo2 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libgdk-pixbuf2.0-0 \
    libffi-dev \
    shared-mime-info
```

These are the binaries that are needed to support mkdocs. Python is already installed in the ```Ubuntu``` image, but is kept 
here for completeness.

```docker
RUN pip3 install \
        --trusted-host=pypi.org \
        --trusted-host=pypi.python.org \
        --trusted-host=files.pythonhosted.org \
        setuptools \
        mkdocs \
        mkdocs-material \
        mkdocs-mermaid-plugin \
        pymdown-extensions \
        pygments \
        plantuml-markdown \
        mkdocs-pdf-export-plugin
```

After the binaries are updated, the ```python``` package installer is used to add the mkdocs and required python packages.

```docker
CMD cd /content && python3 -m mkdocs build
```

Finally the ```mkdocs build``` command is executed to convert all the ```markdown``` source into a static ```html``` site with navigation, indexes, search and offline copies.

The full ```Dockerfile``` here:

```docker
# Mkdocs service

FROM ubuntu:19.10

LABEL maintainer="Steve.Groom@nestle.com"
LABEL version="0.1"
LABEL description="This dockerfile \
installs python and c modules needed \
to run mkdocs with several extensions."

VOLUME /content
VOLUME /stage

RUN apt-get clean
RUN rm -r  /var/lib/apt/lists/*
RUN apt-get update
RUN apt-get --assume-yes install libcairo2  \
    libcairo2-dev \
    build-essential \
    python3-dev \
    python3-pip \
    python3-setuptools \
    python3-wheel \
    python3-cffi \
    libcairo2 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libgdk-pixbuf2.0-0 \
    libffi-dev \
    shared-mime-info
RUN pip3 install \
        --trusted-host=pypi.org \
        --trusted-host=pypi.python.org \
        --trusted-host=files.pythonhosted.org \
        setuptools \
        mkdocs \
        mkdocs-material \
        mkdocs-mermaid-plugin \
        pymdown-extensions \
        pygments \
        plantuml_markdown==3.1.0 \
        mkdocs-pdf-export-plugin
RUN touch /mkdocs_build
#CMD tail -f /dev/null
CMD cd /content && python3 -m mkdocs build
```

## Changelog

31.05.2019 Plantuml_markdown.  
Dockerfile updated to a specific version for this module.
```plantuml_markdown==3.1.0```  
mkdocs.yml to to ```- plantuml_markdown:```.

Plantuml extension was updated 29th May with a module name change that is not 100% rolled out. Sticking to previous version until this works again <https://pypi.org/project/plantuml-markdown/3.1.0/>