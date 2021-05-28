#!/usr/bin/zsh -i

set -o errexit
set -o nounset
set -o pipefail

# Install ASDF Python plugin
asdf plugin-add python
zinit snippet OMZP::python

# Install runtime
asdf install
