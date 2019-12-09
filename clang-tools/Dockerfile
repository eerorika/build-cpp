# https://docs.docker.com/engine/reference/builder/

ARG  BASE
FROM ${BASE}

RUN  apt-get update \
  && apt-get install --no-install-recommends -y \
      clang-format-10 \
      clang-tidy-10 \
      clang-tools-10 \
  && apt-get clean -y
