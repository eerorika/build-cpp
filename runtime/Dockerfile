# https://docs.docker.com/engine/reference/builder/

ARG  BASE
FROM ${BASE}

USER root:root

RUN  export buildpkg="wget gnupg software-properties-common" \
  && apt-get update \
  && apt-get install --no-install-recommends -y $buildpkg \
  && wget https://apt.llvm.org/llvm-snapshot.gpg.key \
        --output-document - | apt-key add - \
  && add-apt-repository \
        "deb http://apt.llvm.org/unstable/ llvm-toolchain main" \
  && apt-mark auto $buildpkg \
  && apt-get autoremove -y \
  && apt-get clean -y

RUN  apt-get update \
  && apt-get install --no-install-recommends -y \
    libstdc++6 \
    libc++1-10 \
  && apt-get clean -y
