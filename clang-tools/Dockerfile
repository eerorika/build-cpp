# https://docs.docker.com/engine/reference/builder/

ARG  BASE
FROM ${BASE}

RUN  apt-get update \
  && apt-get install --no-install-recommends -y \
      clang-format-$V_CLANG \
      clang-tidy-$V_CLANG \
      clang-tools-$V_CLANG \
  && apt-get clean -y \
  && configure-build-env.sh
