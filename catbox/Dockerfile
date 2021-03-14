ARG BASE_IMAGE=docker.pkg.github.com/shikanime/shikanime/papercraft:v0.3
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

FROM base AS asdf

# Install ASDF
ARG ASDF_REPOSITORY="https://github.com/asdf-vm/asdf.git"
RUN git clone "${ASDF_REPOSITORY}" .asdf --branch v0.8.0

FROM base as krew

# Install Krew package manager
ARG KREW_RELEASE_URL="https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.tar.gz"
RUN mkdir -p /tmp/krew-install \
  && cd /tmp/krew-install \
  && curl -fsSLO "${KREW_RELEASE_URL}" \
  && tar zxvf krew.tar.gz ./krew-linux_amd64 \
  && ./krew-linux_amd64 install krew \
  && rm -rf /tmp/krew-install

FROM base AS user

# Copy local dependencies
COPY --from=asdf --chown=sakamoto /home/sakamoto/.asdf .asdf
COPY --from=krew --chown=sakamoto /home/sakamoto/.krew .krew

# Add user configuration
COPY --chown=sakamoto home/sakamoto/.zshrc .zshrc
