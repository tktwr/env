#!/bin/bash

#git ls-files --full-name $(git rev-parse --show-toplevel) | xargs -n 1 dirname | sort --version-sort | uniq | grep --invert-match '^\.$'
git ls-files | xargs -n 1 dirname | sort --version-sort | uniq | grep --invert-match '^\.$'
