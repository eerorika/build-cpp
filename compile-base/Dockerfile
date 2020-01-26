# https://docs.docker.com/engine/reference/builder/

ARG  BASE
FROM ${BASE}

RUN  apt-get update \
  && apt-get install --no-install-recommends -y \
      ccache \
      cmake \
      cppcheck \
      libstdc++-$V_GCC-dev \
      lld-$V_CLANG \
      make \
      ninja-build \
  && update-alternatives --install \
      /usr/bin/lld lld /usr/bin/lld-$V_CLANG $ALT_PRIO \
  && update-alternatives --install \
      /usr/bin/ld  ld  /usr/bin/lld          $ALT_PRIO \
  && apt-get clean -y

ENV PATH="/usr/lib/ccache/:${PATH}"

RUN  export buildpkg="python-pip" \
  && apt-get install --no-install-recommends -y \
      $buildpkg \
      python \
  && pip --no-cache-dir install \
      setuptools \
      wheel \
  && pip --no-cache-dir install \
      conan \
      restore-mtime \
      pullrequest \
      cppcheck-junit \
  && apt-mark auto $buildpkg \
  && apt-get autoremove -y \
  && apt-get clean -y
