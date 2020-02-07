# https://docs.docker.com/engine/reference/builder/

ARG  BASE
FROM ${BASE}

RUN  apt-get update \
  && apt-get install --no-install-recommends -y \
      clang-$V_CLANG \
      libc++-$V_CLANG-dev \
  && configure-build-env.sh
