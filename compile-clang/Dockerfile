# https://docs.docker.com/engine/reference/builder/

ARG  BASE
FROM ${BASE}

RUN  apt-get update \
  && apt-get install --no-install-recommends -y \
      clang-10 \
      libc++-dev \
  && /usr/sbin/update-ccache-symlinks
