# https://docs.docker.com/engine/reference/builder/

ARG  BASE
FROM ${BASE}

RUN  apt-get update \
  && apt-get install --no-install-recommends -y \
      clang-10 \
      libc++-dev \
  && export aliases="clang clang++" \
  && for i in ${aliases}; do \
       update-alternatives --install  /usr/bin/$i $i /usr/bin/$i-10 500; \
     done \
  && update-alternatives --install  /usr/bin/cc cc /usr/bin/clang 500 \
  && update-alternatives --install  /usr/bin/c++ c++ /usr/bin/clang++ 500 \
  && /usr/sbin/update-ccache-symlinks
