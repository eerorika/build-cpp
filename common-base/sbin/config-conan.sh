#!/usr/bin/env sh

# generate initial config
conan profile new default --detect 2> /dev/null

# conan.bintray.com is very slow and default timeout is insufficient
# for searching packages
conan config set general.request_timeout=$((60 * 5))

if [ -n "$CONAN_CMAKE_GENERATOR" ]; then
   conan config set general.cmake_generator="$CONAN_CMAKE_GENERATOR"
fi

if [ -n "$V_CLANG" ]; then
    # add current compiler to conan settings in case it is missing
	if command -v conan-settings > /dev/null; then
		echo "compiler: { clang: { version: ['$V_CLANG']}}" | conan-settings
	fi
	if [ "$CC_ALT" = "clang" ]; then
	    # set compiler as default
		conan profile update "settings.compiler=clang" default
		conan profile update "settings.compiler.version=$V_CLANG" default
	fi
fi
if [ -n "$V_GCC" ]; then
	if command -v conan-settings > /dev/null; then
		echo "compiler: { gcc: { version: ['$V_GCC' ]}}" | conan-settings
	fi
	if [ "$CC_ALT" = "gcc" ]; then
		conan profile update "settings.compiler=gcc" default
		conan profile update "settings.compiler.version=$V_GCC" default
	fi
fi

if [ -n "$CONAN_LIBCXX_ALT" ]; then
	conan profile update "settings.compiler.libcxx=$CONAN_LIBCXX_ALT" default
fi
