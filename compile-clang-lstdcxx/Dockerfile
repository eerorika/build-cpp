# https://docs.docker.com/engine/reference/builder/

ARG  BASE
FROM ${BASE}

RUN  apt-get update \
  && apt-get install --no-install-recommends -y \
      libstdc++-$V_GCC-dev

ENV CLANG_DEFAULT_CXX_STDLIB=libstdc++ \
    CONAN_LIBCXX_ALT=libstdc++11 \
    CXXFLAGS="$CXXFLAGS -stdlib=libstdc++"

RUN  configure-build-env.sh
