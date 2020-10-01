# https://docs.docker.com/engine/reference/builder/

ARG  BASE
FROM ${BASE}

USER root:root

ARG V_CLANG

ENV V_CLANG=$V_CLANG

ADD build .

RUN  sh apt-llvm.sh \
  && rm apt-llvm.sh

USER 1000:1000
