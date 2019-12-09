# https://docs.docker.com/engine/reference/builder/

ARG  BASE
FROM ${BASE}

RUN  apt-get update \
  && apt-get install --no-install-recommends -y \
      clang-format-10 \
      clang-tidy-10 \
      clang-tools-10 \
  && update-alternatives --install \
      /usr/bin/clang-tidy-diff-10 clang-tidy-diff-10 \
      /usr/bin/clang-tidy-diff-10.py 500 \
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
       update-alternatives --install /usr/bin/$i $i /usr/bin/$i-10 500; \
     done \
  && apt-get clean -y
