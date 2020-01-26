# https://docs.docker.com/engine/reference/builder/

ARG  BASE
FROM ${BASE}

ARG APT_DISTRO=unstable
ARG V_LIBSTD=6
ARG V_CLANG=11

USER root:root

RUN  export buildpkg="wget gnupg software-properties-common" \
  && apt-get update \
  && apt-get install --no-install-recommends -y $buildpkg \
  && wget https://apt.llvm.org/llvm-snapshot.gpg.key \
        --output-document - | apt-key add - \
  && add-apt-repository \
        "deb http://apt.llvm.org/$APT_DISTRO/ llvm-toolchain main" \
  && apt-mark auto $buildpkg \
  && apt-get autoremove -y \
  && apt-get clean -y

RUN  apt-get update \
  && apt-get install --no-install-recommends -y \
    libstdc++$V_LIBSTD \
    libc++1-$V_CLANG \
  && apt-get clean -y
