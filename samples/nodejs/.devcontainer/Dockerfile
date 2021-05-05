FROM docker.pkg.github.com/shikanime/shikanime/catbox:0.3.2-nodejs-debian-bullseye-20210111 AS base

# Add ASDF NodeJS plugin
RUN asdf plugin-add nodejs

# Imports Node.js release team's OpenPGP keys to the keyring
RUN GNUPGHOME="${ASDF_DIR:-${HOME}/.asdf}/keyrings/nodejs" \
  && mkdir -p "${GNUPGHOME}" \
  && chmod 0700 "${GNUPGHOME}" \
  && bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
