ARG BASE_IMAGE
FROM ${BASE_IMAGE} AS genesis

FROM genesis AS system

LABEL maintainer="Shikanime Deva <deva.shikanime@protonmail.com>"

# Install essential packages
RUN --mount=type=cache,sharing=private,target=/var/cache/apt --mount=from=genesis,target=/var/lib/apt/lists \
  apt-get update -y && apt-get install -y --no-install-recommends \
  gnupg2 vim ssh

FROM system AS base

# Add user configuration
COPY --chown=sakamoto home/sakamoto/.gitconfig /home/sakamoto/.gitconfig
COPY --chown=sakamoto home/sakamoto/.gitignore /home/sakamoto/.gitignore
COPY --chown=sakamoto home/sakamoto/.zshenv /home/sakamoto/.zshenv
COPY --chown=sakamoto home/sakamoto/.zshrc /home/sakamoto/.zshrc
