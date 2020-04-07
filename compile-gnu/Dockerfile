# https://docs.docker.com/engine/reference/builder/

ARG  BASE
FROM ${BASE}

ENV CC_ALT=gcc \
    CXX_ALT=g++ \
    LD_ALT=gold \
    AR_ALT=gcc-ar \
    NM_ALT=gcc-nm \
    RANLIB_ALT=gcc-ranlib \
    LIBCXX_ALT=libstdc++11

RUN  apt-get update \
  && apt-get install --no-install-recommends -y \
      g++-$V_GCC \
      gcc-$V_GCC \
  && apt-get clean -y \
  && configure-build-env.sh \
  && /usr/sbin/update-ccache-symlinks
