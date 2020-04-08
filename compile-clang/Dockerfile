# https://docs.docker.com/engine/reference/builder/

ARG  BASE
FROM ${BASE}

RUN  apt-get update \
  && apt-get install --no-install-recommends -y \
      clang-$V_CLANG \
      libc++-$V_CLANG-dev

ENV CC_ALT=clang \
    CXX_ALT=clang++ \
    LD_ALT=lld \
    AR_ALT=llvm-ar \
    NM_ALT=llvm-nm \
    RANLIB_ALT=llvm-ranlib \
    CLANG_DEFAULT_CXX_STDLIB=libc++ \
    LIBCXX_ALT=libc++ \
    CXXFLAGS="$CXXFLAGS -stdlib=libc++"

RUN  configure-build-env.sh \
  && /usr/sbin/update-ccache-symlinks
