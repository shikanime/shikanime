ARG BASE_IMAGE=docker.pkg.github.com/shikanime/shikanime/base:v0.3
FROM ${BASE_IMAGE} AS genesis

FROM genesis AS system

LABEL maintainer="Shikanime Deva <deva.shikanime@protonmail.com>"

# Enfore root user for system installation
USER root

# Install essential packages
RUN --mount=type=cache,target=/var/cache/apt --mount=from=genesis,target=/var/lib/apt/lists \
  apt-get update -y && apt-get install -y --no-install-recommends \
  ca-certificates curl gnupg2 git gcc g++ make libc6-dev \
  libffi-dev libgmp-dev zlib1g-dev xz-utils netbase

FROM system as stack

# Haskell development tools
ARG STACK_INSTALL_SCRIPT_URL="https://get.haskellstack.org"
RUN curl -sSL "${STACK_INSTALL_SCRIPT_URL}" | sh

FROM system AS base

# Switch to user context
WORKDIR /home/sakamoto
USER sakamoto

FROM base as rustup

# Install Rust development tools
ARG RUSTUP_INSTALL_SCRIPT_URL="https://sh.rustup.rs"
RUN curl --proto '=https' --tlsv1.2 -sSf "${RUSTUP_INSTALL_SCRIPT_URL}" | sh -s -- -y --default-toolchain none

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
COPY --from=stack --chown=sakamoto /usr/local/bin/stack .local/bin/stack
COPY --from=asdf --chown=sakamoto /home/sakamoto/.asdf .asdf
COPY --from=rustup --chown=sakamoto /home/sakamoto/.cargo .cargo
COPY --from=rustup --chown=sakamoto /home/sakamoto/.rustup .rustup
COPY --from=krew --chown=sakamoto /home/sakamoto/.krew .krew

# Add user configuration
COPY --chown=sakamoto home/sakamoto/.zshrc .zshrc
