ARG BASE_IMAGE=docker.pkg.github.com/shikanime/shikanime/papercraft
FROM ${BASE_IMAGE} AS genesis

FROM genesis AS system

LABEL maintainer="Shikanime Deva <deva.shikanime@protonmail.com>"

# Enfore root user for system installation
USER root

# Install essential packages
RUN --mount=type=cache,target=/var/cache/apt --mount=from=genesis,target=/var/lib/apt/lists \
  apt-get update -y && apt-get install -y --no-install-recommends \
  ca-certificates curl git

FROM system AS base

# Switch to user context
WORKDIR /home/sakamoto
USER sakamoto

# Install ASDF
ARG ASDF_REPOSITORY="https://github.com/asdf-vm/asdf.git"
RUN git clone "${ASDF_REPOSITORY}" .asdf --branch v0.8.0

# Add user configuration
COPY --chown=sakamoto home/sakamoto/.zshrc .zshrc
