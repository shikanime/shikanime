ARG BASE_IMAGE
FROM ${BASE_IMAGE} AS genesis

FROM genesis AS system

LABEL maintainer="Shikanime Deva <deva.shikanime@protonmail.com>"

# Enfore root user for system installation
USER root

# Install essential packages
RUN --mount=type=cache,target=/var/cache/apt --mount=from=genesis,target=/var/lib/apt/lists \
  apt-get update -y && apt-get install -y --no-install-recommends \
  gnupg2 vim ssh

FROM system AS base

# Switch to user context
WORKDIR /home/sakamoto
USER sakamoto

# Add user configuration
COPY --chown=sakamoto home/sakamoto/.gitconfig .gitconfig
COPY --chown=sakamoto home/sakamoto/.gitignore .gitignore
COPY --chown=sakamoto home/sakamoto/.zshrc .zshrc
