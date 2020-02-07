# https://docs.docker.com/engine/reference/builder/

ARG  BASE
FROM ${BASE}

RUN  apt-get update \
  && apt-get install --no-install-recommends -y \
      g++-$V_GCC \
      gcc-$V_GCC \
  && apt-get clean -y \
  && configure-build-env.sh
