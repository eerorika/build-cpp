# https://docs.docker.com/engine/reference/builder/

ARG  BASE
FROM ${BASE}

USER root:root

ENV CONAN_LIBCXX_ALT=libstdc++11 \
    CC_ALT=gcc \
    CXX_ALT=g++

RUN  update-alternatives --install /usr/bin/ld ld /usr/bin/gold 500 \
  && config-ccache.sh \
  && config-conan.sh

USER 1000:1000

RUN config-conan.sh
