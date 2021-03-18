FROM docker.pkg.github.com/shikanime/shikanime/catbox:v0.3 AS base

# Switch to root user for system installation
USER root

# Install essential packages
RUN --mount=type=cache,target=/var/cache/apt \
  apt-get update -y && apt-get install -y --no-install-recommends \
  python3 make g++

# Switch to user land
USER sakamoto

FROM base

# Add ASDF NodeJS plugin
RUN asdf plugin-add nodejs

# Imports Node.js release team's OpenPGP keys to the keyring
RUN GNUPGHOME="${ASDF_DIR:-${HOME}/.asdf}/keyrings/nodejs" \
  && mkdir -p "${GNUPGHOME}" \
  && chmod 0700 "${GNUPGHOME}" \
  && bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
