# https://docs.docker.com/engine/reference/builder/

ARG  BASE
FROM ${BASE}

RUN  apt-get update \
  && apt-get install --no-install-recommends -y \
      g++-9 \
      gcc-9 \
  && aliases="gcc g++" \
  && for i in ${aliases}; do \
       update-alternatives --install  /usr/bin/$i $i /usr/bin/$i-9 500; \
     done \
  && update-alternatives --install  /usr/bin/cc cc /usr/bin/gcc 500 \
  && update-alternatives --install  /usr/bin/c++ c++ /usr/bin/g++ 500 \
  && apt-get clean -y \
  && /usr/sbin/update-ccache-symlinks
