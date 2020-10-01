# https://docs.docker.com/engine/reference/builder/

ARG  BASE
FROM ${BASE}

USER root:root

RUN  apt-get update \
  && apt-get install --no-install-recommends -y \
      clang-$V_CLANG
      # libstdc++ may be needed
      #libstdc++-$V_GCC-dev

ENV CC_ALT=clang \
    CXX_ALT=clang++ \
    LD_ALT=lld \
    AR_ALT=llvm-ar \
    NM_ALT=llvm-nm \
    RANLIB_ALT=llvm-ranlib

RUN  config-build-env.sh \
  && config-ccache.sh \
  && config-conan.sh

USER 1000:1000

RUN config-conan.sh
