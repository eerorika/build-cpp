# https://docs.docker.com/engine/reference/builder/

ARG  BASE
FROM ${BASE}

RUN  apt-get update \
  && apt-get install --no-install-recommends -y \
      ccache \
      cmake \
      cppcheck \
      libstdc++-9-dev \
      lld-10 \
      make \
      ninja-build \
  && update-alternatives --install \
      /usr/bin/lld lld /usr/bin/lld-10 500 \
  && update-alternatives --install \
      /usr/bin/ld ld /usr/bin/lld 500 \
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
      cppcheck-junit \
  && apt-mark auto $buildpkg \
  && apt-get autoremove -y \
  && apt-get clean -y
