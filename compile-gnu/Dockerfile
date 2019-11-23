# https://docs.docker.com/engine/reference/builder/

ARG  BASE
FROM ${BASE}

RUN  apt-get update \
  && apt-get install --no-install-recommends -y \
      g++-9 \
      gcc-9 \
  && apt-get clean -y \
  && /usr/sbin/update-ccache-symlinks
