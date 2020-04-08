# https://docs.docker.com/engine/reference/builder/

ARG  BASE
FROM ${BASE}

USER root:root

RUN export distro=$( \
      grep -o '^[^#]*' /etc/apt/sources.list \
      | head -n1 \
      | cut -d ' ' -f 3 \
      | cut -d '/' -f 1 \
      | cut -d '-' -f 1 \
    ) \
    export buildpkg="wget gnupg software-properties-common" \
  && apt-get update \
  && apt-get install --no-install-recommends -y $buildpkg \
  && wget https://apt.llvm.org/llvm-snapshot.gpg.key \
        --output-document - | apt-key add - \
  && add-apt-repository \
        "deb http://apt.llvm.org/$distro/ llvm-toolchain main" \
  && apt-mark auto $buildpkg \
  && apt-get autoremove -y \
  && apt-get clean -y

ARG V_CLANG_ARG
ARG V_GCC_ARG
ARG V_LIBSTD_ARG
ARG V_LIBCXX_ARG
ARG ALT_PRIO_ARG=500

ENV V_CLANG=$V_CLANG_ARG \
    V_GCC=$V_GCC_ARG \
    V_LIBSTD=$V_LIBSTD_ARG \
    V_LIBCXX=$V_LIBCXX_ARG \
    ALT_PRIO=$ALT_PRIO_ARG

RUN  apt-get update \
  && apt-get install --no-install-recommends -y \
    libstdc++$V_LIBSTD \
    libc++$V_LIBCXX-$V_CLANG \
  && apt-get clean -y
