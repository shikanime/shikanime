#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# Update workflows
bash "$(dirname "$0")"/.github/workflows/update.sh 2>&1 |
  sed 's/^/['workflows'] /'
