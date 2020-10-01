# https://docs.docker.com/engine/reference/builder/

ARG  BASE
FROM ${BASE}

USER root:root

RUN  apt-get update \
  && apt-get install --no-install-recommends -y \
      libstdc++-$V_GCC-dev

ENV CLANG_DEFAULT_CXX_STDLIB=libstdc++ \
    CONAN_LIBCXX_ALT=libstdc++11 \
    CXXFLAGS="$CXXFLAGS -stdlib=libstdc++"

RUN  config-build-env.sh \
  && config-conan.sh \
  && config-ccache.sh

USER 1000:1000

RUN config-conan.sh
