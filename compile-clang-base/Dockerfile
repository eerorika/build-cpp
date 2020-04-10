# https://docs.docker.com/engine/reference/builder/

ARG  BASE
FROM ${BASE}

RUN  apt-get update \
  && apt-get install --no-install-recommends -y \
      clang-$V_CLANG \
      libstdc++-$V_GCC-dev

ENV CC_ALT=clang \
    CXX_ALT=clang++ \
    LD_ALT=lld \
    AR_ALT=llvm-ar \
    NM_ALT=llvm-nm \
    RANLIB_ALT=llvm-ranlib

RUN  configure-build-env.sh
