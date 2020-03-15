#!/usr/bin/env sh

/usr/sbin/update-ccache-symlinks

alt_prio=${ALT_PRIO:-500}
set_alt() {
	path="$1"
	alt=$(command -v "$2")
	cmd=$(basename "$path")
	slaves="$3"
	if [ -x "$alt" ]; then
		# shellcheck disable=SC2086
		update-alternatives \
			--install "$path" "$cmd" "$alt" "$alt_prio" $slaves
		update-alternatives --set "$cmd" "$alt"
	fi
}

set_alt_version() {
	version="$1"
	master="$2"
	shift
	shift
	slaves=""
	for i; do
		alt=$(command -v "/usr/bin/$i-$version")
		if [ -x "$alt" ]; then
			slaves="$slaves --slave /usr/bin/$i $i $alt"
			if [ -L "/etc/alternatives/$i" ]; then
				update-alternatives --remove-all "$i"
			fi
		fi
    done
    set_alt "/usr/bin/$master" "/usr/bin/$master-$version" "$slaves"
}

set_clang_py_link() {
	cmd="$1"
	path="/usr/bin/$cmd-$V_CLANG"
	if [ ! -f "$path" ]; then
		if [ -x "/usr/bin/$cmd-$V_CLANG.py" ]; then
			ln -s "/usr/bin/$cmd-$V_CLANG.py" "$path"
		elif [ -x "/usr/lib/llvm-$V_CLANG/share/clang/$cmd.py" ]; then
			ln -s "/usr/lib/llvm-$V_CLANG/share/clang/$cmd.py" "$path"
		elif [ -x "/usr/share/clang/clang-format-$V_CLANG/$cmd.py" ]; then
			ln -s "/usr/share/clang/clang-format-$V_CLANG/$cmd.py" "$path"
		fi
	fi
}

if [ -n "$V_CLANG" ]; then
	if command -v conan-settings; then
		echo "compiler: { clang: { version: ['$V_CLANG']}}" | conan-settings
	fi
	set_clang_py_link clang-format
	set_clang_py_link clang-format-diff
	set_clang_py_link clang-format-sublime
	set_clang_py_link clang-include-fixer
	set_clang_py_link clang-rename
	set_clang_py_link clang-tidy-diff
	set_clang_py_link run-clang-tidy
	set_clang_py_link run-find-all-symbols
	set_alt_version \
		"$V_CLANG" \
		clang \
			bugpoint \
			clang++ \
			clang-apply-replacements \
			clang-change-namespace \
			clang-check \
			clang-cl \
			clang-cpp \
			clang-doc \
			clang-extdef-mapping \
			clang-format \
			clang-format-diff \
			clang-format-sublime \
			clang-import-test \
			clang-include-fixer \
			clang-move \
			clang-offload-bundler \
			clang-query \
			clang-refactor \
			clang-rename \
			clang-reorder-fields \
			clang-scan-deps \
			clang-tidy \
			clang-tidy-diff \
			clangd \
			dsymutil \
			FileCheck \
			git-clang-format \
			ldd \
			lit \
			llc \
			lld-link \
			lldb \
			lldb-argdumper \
			lldb-instr \
			lldb-server \
			lldb-vscode \
			lli \
			lli-child-target \
			llvm-addr2line \
			llvm-ar \
			llvm-bcanalyzer \
			llvm-c-test \
			llvm-cat \
			llvm-cfi-verify \
			llvm-config \
			llvm-cov \
			llvm-cvtres \
			llvm-cxxdump \
			llvm-cxxfilt \
			llvm-cxxmap \
			llvm-dif \
			llvm-dis \
			llvm-dlltool \
			llvm-dwarfdump \
			llvm-dwp \
			llvm-elfabi \
			llvm-exegesis \
			llvm-extract \
			llvm-ifs \
			llvm-install-name-tool \
			llvm-jitlink \
			llvm-lib \
			llvm-link \
			llvm-lipo \
			llvm-lto \
			llvm-lto2 \
			llvm-mc \
			llvm-mca \
			llvm-ml \
			llvm-modextract \
			llvm-mt \
			llvm-nm \
			llvm-objcopy \
			llvm-objdump \
			llvm-opt-report \
			llvm-pdbutil \
			llvm-PerfectShuffle \
			llvm-profdata \
			llvm-ranlib \
			llvm-rc \
			llvm-readelf \
			llvm-readobj \
			llvm-reduce \
			llvm-rtdyld \
			llvm-size \
			llvm-split \
			llvm-stress \
			llvm-strings \
			llvm-strip \
			llvm-tblgen \
			llvm-undname \
			llvm-xray \
			opt \
			run-clang-tidy \
			run-find-all-symbols \
			scan-build \
			scan-build-py \
			scan-build-view \
			tblgen
fi
if [ -n "$V_GCC" ]; then
	if command -v conan-settings; then
		echo "compiler: { gcc: { version: ['$V_GCC' ]}}" | conan-settings
	fi
	set_alt_version \
		"$V_GCC" \
		gcc \
			g++ \
			gcc-ar \
			gcc-nm \
			gcc-ranlib \
			gcov \
			gcov-dump \
			gcov-tool
fi

if [ -x "$LD_ALT" ]; then
	set_alt /usr/bin/ld "$LD_ALT"
fi
if [ -n "$CC_ALT" ]; then
	set_alt /usr/bin/cc "$CC_ALT"
fi
if [ -n "$CXX_ALT" ]; then
	set_alt /usr/bin/c++ "$CXX_ALT"
fi