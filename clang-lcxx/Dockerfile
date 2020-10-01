# https://docs.docker.com/engine/reference/builder/

ARG  BASE
FROM ${BASE}

USER root:root

RUN  apt-get update \
  && apt-get install --no-install-recommends -y \
      libc++-$V_CLANG-dev

ENV CLANG_DEFAULT_CXX_STDLIB=libc++ \
    CONAN_LIBCXX_ALT=libc++ \
    CXXFLAGS="$CXXFLAGS -stdlib=libc++"

RUN  config-build-env.sh \
  && config-conan.sh

USER 1000:1000

RUN config-conan.sh
