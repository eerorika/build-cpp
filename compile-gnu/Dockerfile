# https://docs.docker.com/engine/reference/builder/

ARG  BASE
FROM ${BASE}

RUN  apt-get update \
  && apt-get install --no-install-recommends -y \
      g++-$V_GCC \
      gcc-$V_GCC \
  && aliases="gcc g++" \
  && for i in ${aliases}; do \
       update-alternatives --install \
         /usr/bin/$i $i /usr/bin/$i-$V_GCC $ALT_PRIO; \
     done \
  && update-alternatives --install  /usr/bin/cc  cc  /usr/bin/gcc $ALT_PRIO \
  && update-alternatives --install  /usr/bin/c++ c++ /usr/bin/g++ $ALT_PRIO \
  && apt-get clean -y \
  && /usr/sbin/update-ccache-symlinks
