# https://docs.docker.com/engine/reference/builder/

ARG  BASE
FROM ${BASE}

USER root:root

RUN  apt-get update \
  && apt-get install --no-install-recommends -y \
      # general CI
      ca-certificates \
      git \
      gzip \
      openssh-client \
      tar \
      # C and C++
      ccache \
      cmake \
      cppcheck \
      make \
      ninja-build \
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
  && apt-get clean -y \
  && adduser \
      --disabled-password \
      --gecos GECOS \
      -u 1000 \
        user

ADD sbin /usr/local/bin/

RUN chmod a+x /usr/local/bin/config-*.sh

USER 1000:1000
