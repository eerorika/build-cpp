#!/usr/bin/env sh

# default to current compiler version
if [ -z "$V_CLANG" ] && command -v clang 2> /dev/null; then
	current=$(clang --version \
		| head -1 \
		| grep --only-matching 'version [[:digit:]]\+' \
		| grep --only-matching '[[:digit:]]\+' \
		| head -1)
	if [ -n "$current" ] && command -v "clang-$current"; then
		echo "defaulting to clang version $current"
		export V_CLANG=$current
	fi
fi
if [ -z "$V_GCC" ] && command -v gcc 2> /dev/null; then
	current=$(gcc --version \
		| head -1 \
		| cut --delimiter=' ' --fields=4 \
		| grep --only-matching '[[:digit:]]\+' \
		| head -1)
	if [ -n "$current" ] && command -v "gcc-$current"; then
		echo "defaulting to gcc version $current"
		export V_GCC=$current
	fi
fi

usrs="/usr/local /usr"

set_alt() {
	alt_prio=${ALT_PRIO:-500}
	path="$1"
	alt=$(command -v "$2")
	cmd=$(basename "$path")
	slaves="$3"
	if [ -n "$alt" ] && [ -x "$alt" ]; then
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
	for usr in $usrs; do
        alt="$usr/bin/$master-$version"
        if [ -x "$alt" ]; then
            for i; do
                alt="$usr/bin/$i-$version"
                if [ -x "$alt" ]; then
                    slaves="$slaves --slave $usr/bin/$i $i $alt"
                    if [ -L "/etc/alternatives/$i" ]; then
                        update-alternatives --remove-all "$i" 2> /dev/null
                    fi
                fi
            done
            set_alt "$usr/bin/$master" "$alt" "$slaves"
            break
        fi
    done
}
set_clang_py_link() {
	cmd="$1"
	for usr in $usrs; do
	    path="$usr/bin/$cmd-$V_CLANG"
        if [ ! -f "$path" ]; then
            if [ -x "$usr/bin/$cmd-$V_CLANG.py" ]; then
                ln -s "$usr/bin/$cmd-$V_CLANG.py" "$path"
            elif [ -x "$usr/lib/llvm-$V_CLANG/share/clang/$cmd.py" ]; then
                ln -s "$usr/lib/llvm-$V_CLANG/share/clang/$cmd.py" "$path"
            elif [ -x "$usr/share/clang/clang-format-$V_CLANG/$cmd.py" ]; then
                ln -s "$usr/share/clang/clang-format-$V_CLANG/$cmd.py" "$path"
            fi
        fi
    done
}

if [ -n "$V_CLANG" ]; then
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
			asan_symbolize \
			bugpoint \
			c-index-test \
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
			clang-offload-wrapper \
			clang-query \
			clang-refactor \
			clang-rename \
			clang-reorder-fields \
			clang-scan-deps \
			clang-tidy \
			clang-tidy-diff \
			clangd \
			count \
			diagtool \
			dsymutil \
			FileCheck \
			find-all-symbols \
			git-clang-format \
			hmaptool \
			hwasan_symbolize \
			ld.lld \
			ld64.lld \
			ldd \
			lit \
			llc \
			lld \
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
			llvm-as \
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
			llvm-diff \
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
			llvm-symbolizer \
			llvm-tblgen \
			llvm-undname \
			llvm-xray \
			modularize \
			not \
			obj2yaml \
			opt \
			pp-trace \
			run-clang-tidy \
			run-find-all-symbols \
			sancov \
			sanstats \
			scan-build \
			scan-build-py \
			scan-build-view \
			scan-view \
			split-file \
			verify-uselistorder \
			wasm-ld \
			yaml-bench \
			yaml2obj \
			tblgen
fi
if [ -n "$V_GCC" ]; then
	target="$(echo "$(uname -m)-$(uname -s)" | tr '[:upper:]' '[:lower:]')"
	set_alt_version \
		"$V_GCC" \
		gcc \
			g++ \
			gcc-ar \
			gcc-nm \
			gcc-ranlib \
			gcov \
			gcov-dump \
			gcov-tool \
			"$target-gnu-cpp" \
			"$target-gnu-g++" \
			"$target-gnu-gcc" \
			"$target-gnu-gcc-ar" \
			"$target-gnu-gcc-nm" \
			"$target-gnu-gcc-ranlib" \
			"$target-gnu-gcov" \
			"$target-gnu-gcov-dump" \
			"$target-gnu-gcov-tool"
fi


if [ -n "$CC_ALT" ]; then
    set_alt "/usr/bin/cc" "$CC_ALT"
fi
if [ -n "$CXX_ALT" ]; then
    set_alt "/usr/bin/c++" "$CXX_ALT"
fi
if [ -x "$LD_ALT" ]; then
    set_alt "/usr/bin/ld" "$LD_ALT"
fi
if [ -n "$AR_ALT" ]; then
    set_alt "/usr/bin/ar" "$AR_ALT"
fi
if [ -n "$NM_ALT" ]; then
    set_alt "/usr/bin/nm" "$NM_ALT"
fi
if [ -n "$RANLIB_ALT" ]; then
    set_alt "/usr/bin/ranlib" "$RANLIB_ALT"
fi
