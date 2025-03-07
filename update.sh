#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# Update gitignore
gitnr create \
  ghc:Nix \
  repo:shikanime/gitignore/refs/heads/main/Devenv.gitignore \
  tt:jetbrains+all \
  tt:Linux \
  tt:Macos \
  tt:Terraform \
  tt:vim \
  tt:visualstudiocode \
  tt:Windows >.gitignore
