# https://docs.docker.com/engine/reference/builder/

ARG  BASE
FROM ${BASE}

RUN  apt-get update \
  && apt-get install --no-install-recommends -y \
      ccache \
      cmake \
      libstdc++-9-dev \
      lld \
      make \
      ninja-build \
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
  && apt-mark auto $buildpkg \
  && apt-get autoremove -y \
  && apt-get clean -y
