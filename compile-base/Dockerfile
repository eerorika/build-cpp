# https://docs.docker.com/engine/reference/builder/

ARG  BASE
FROM ${BASE}

RUN  apt-get update \
  && apt-get install --no-install-recommends -y \
      ccache \
      cmake \
      cppcheck \
      make \
      ninja-build \
  && apt-get clean -y \
  && export buildpkg="python3-pip" \
  && apt-get install --no-install-recommends -y \
      $buildpkg \
      python3-minimal \
      python3-distutils \
  && pip3 --no-cache-dir install \
      setuptools \
      wheel \
  && pip3 --no-cache-dir install \
      conan \
      conan-settings \
      restore-mtime \
      pullrequest \
      cppcheck-junit \
  && rm -rf ~/.cache/pip /tmp/pip_build_$USER /tmp/pip_build_$USER \
  && apt-mark auto $buildpkg \
  && apt-get autoremove -y \
  && apt-get clean -y

ENV PATH="/usr/lib/ccache/:${PATH}"
ADD configure-build-env.sh /usr/local/bin/

RUN  chmod u+x /usr/local/bin/configure-build-env.sh \
  && configure-build-env.sh
