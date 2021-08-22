# https://docs.docker.com/engine/reference/builder/

ARG  BASE
FROM ${BASE}

USER root:root

ARG V_LIBSTD
ARG V_LIBCXX

ENV V_LIBSTD=$V_LIBSTD \
    V_LIBCXX=$V_LIBCXX

RUN  apt-get -y update \
  && apt-get install --no-install-recommends -y \
    libstdc++${V_LIBSTD:-6} \
    libc++${V_LIBCXX:-1}-${V_CLANG:-13} \
  && apt-get clean -y

USER 1000:1000

