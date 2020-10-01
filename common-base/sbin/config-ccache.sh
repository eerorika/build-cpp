#!/usr/bin/env sh

# using /usr/local/sbin to allow compiler to exist in /usr/local/bin
ccache_links=/usr/local/sbin
if command -v ccache; then
    ccache=$(command -v ccache)
	ln -sf "$ccache" "$ccache_links/cc"
	ln -sf "$ccache" "$ccache_links/c++"
	ln -sf "$ccache" "$ccache_links/clang"
	ln -sf "$ccache" "$ccache_links/clang++"
	ln -sf "$ccache" "$ccache_links/gcc"
	ln -sf "$ccache" "$ccache_links/g++"
	if [ -n "$V_CLANG" ]; then
		ln -sf "$ccache" "$ccache_links/clang-$V_CLANG"
		ln -sf "$ccache" "$ccache_links/clang++-$V_CLANG"
	fi
	if [ -n "$V_GCC" ]; then
		ln -sf "$ccache" "$ccache_links/gcc-$V_GCC"
		ln -sf "$ccache" "$ccache_links/g++-$V_GCC"
	fi
fi
