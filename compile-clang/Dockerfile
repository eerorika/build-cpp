# https://docs.docker.com/engine/reference/builder/

ARG  BASE
FROM ${BASE}

RUN  apt-get update \
  && apt-get install --no-install-recommends -y \
      clang-$V_CLANG \
      libc++-$V_CLANG-dev \
  && export aliases="clang clang++" \
  && for i in ${aliases}; do \
       update-alternatives --install \
         /usr/bin/$i $i /usr/bin/$i-$V_CLANG $ALT_PRIO; \
     done \
  && update-alternatives --install /usr/bin/cc  cc  /usr/bin/clang   $ALT_PRIO \
  && update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++ $ALT_PRIO \
  && /usr/sbin/update-ccache-symlinks \
  && update-alternatives --install /usr/bin/ld  ld  $LD_ALT          $ALT_PRIO \
