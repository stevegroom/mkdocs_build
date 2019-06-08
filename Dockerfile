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
        markdown \
        setuptools \
        mkdocs \
        mkdocs-material \
        mkdocs-mermaid-plugin \
        pymdown-extensions \
        pygments \
        plantuml_markdown==3.1.0 \
        mkdocs-pdf-export-plugin \
        WeasyPrint
RUN touch /mkdocs_build

EXPOSE 8000

WORKDIR /content
#CMD tail -f /dev/null
#ENTRYPOINT [ "exec", "python3", "-m"]
CMD cd /content && python3 -m mkdocs build 
 