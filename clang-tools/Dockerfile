# https://docs.docker.com/engine/reference/builder/

ARG  BASE
FROM ${BASE}

USER root:root

RUN  apt-get update \
  && apt-get install --no-install-recommends -y \
      clang-format-$V_CLANG \
      clang-tidy-$V_CLANG \
      clang-tools-$V_CLANG \
  && apt-get clean -y \
  && config-build-env.sh

USER 1000:1000
