# https://docs.docker.com/engine/reference/builder/

ARG  BASE
FROM ${BASE}

RUN  apt-get update \
  && apt-get install --no-install-recommends -y \
      libc++-$V_CLANG-dev

ENV CLANG_DEFAULT_CXX_STDLIB=libc++ \
    CONAN_LIBCXX_ALT=libc++ \
    CXXFLAGS="$CXXFLAGS -stdlib=libc++"

RUN  configure-build-env.sh
