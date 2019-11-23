# https://docs.docker.com/engine/reference/builder/

ARG  BASE
FROM ${BASE}

RUN  apt-get update \
  && apt-get install --no-install-recommends -y \
    ca-certificates \
    git \
    gzip \
    openssh-client \
    tar \
  && apt-get clean -y
