#!/usr/bin/zsh -i

set -o errexit
set -o nounset
set -o pipefail

# Add ASDF NodeJS plugin
asdf plugin-add nodejs
zinit snippet OMZP::node

# Imports Node.js release team's OpenPGP keys to the keyring
GNUPGHOME="${ASDF_DIR:-${HOME}/.asdf}/keyrings/nodejs"
mkdir -p "${GNUPGHOME}"
chmod 0700 "${GNUPGHOME}"
bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring

# Install runtime
asdf install
