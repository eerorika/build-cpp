#!/bin/sh

distro="$(
  grep -o '^[^#]*' /etc/apt/sources.list \
    | head -n1 \
    | cut -d ' ' -f 3 \
    | cut -d '/' -f 1 \
    | cut -d '-' -f 1
)"

if [ "$distro" = 'stable' ]; then
    . /etc/os-release
    distro=$VERSION_CODENAME
fi

if [ "$distro" = 'unstable' ]; then
    toolchain="llvm-toolchain-$V_CLANG"
    toolchain_latest="llvm-toolchain"
else
    toolchain="llvm-toolchain-$distro-$V_CLANG"
    toolchain_latest="llvm-toolchain-$distro"
fi

build_dep="wget gnupg software-properties-common"
export DEBIAN_FRONTEND=noninteractive
apt-get --yes update
# shellcheck disable=SC2086
apt-get install --no-install-recommends --yes $build_dep

wget https://apt.llvm.org/llvm-snapshot.gpg.key \
  --output-document - \
  | apt-key add -

add-apt-repository \
    "deb http://apt.llvm.org/$distro/ $toolchain main" \
&& apt-get update \
    || add-apt-repository --remove \
        "deb http://apt.llvm.org/$distro/ $toolchain main" \
    && add-apt-repository \
        "deb http://apt.llvm.org/$distro/ $toolchain_latest main" \
    && apt-get update \

# shellcheck disable=SC2086
apt-mark auto $build_dep
apt-get autoremove --yes
apt-get clean --yes
