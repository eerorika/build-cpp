# https://docs.docker.com/engine/reference/builder/

ARG  BASE
FROM ${BASE}

RUN  apt-get update \
  && apt-get install --no-install-recommends -y \
      clang-format-$V_CLANG \
      clang-tidy-$V_CLANG \
      clang-tools-$V_CLANG \
  && update-alternatives --install \
      /usr/bin/clang-tidy-diff-$V_CLANG clang-tidy-diff-$V_CLANG \
      /usr/bin/clang-tidy-diff-$V_CLANG.py $ALT_PRIO \
  && export aliases="\
      clang-format \
      clang-format-diff \
      clang-tidy \
      clang-tidy-diff \
      clang-apply-replacements \
      clang-change-namespace \
      clang-check \
      clang-cl \
      clang-doc \
      clang-extdef-mapping \
      clang-import-test \
      clang-include-fixer \
      clang-offload-bundler \
      clang-query \
      clang-refactor \
      clang-rename \
      clang-reorder-fields \
      " \
  && for i in ${aliases}; do \
       update-alternatives --install \
         /usr/bin/$i $i /usr/bin/$i-$V_CLANG $ALT_PRIO; \
     done \
  && apt-get clean -y \
  && update-alternatives --install /usr/bin/ld ld $LD_ALT $ALT_PRIO \
