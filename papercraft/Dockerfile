ARG BASE_IMAGE
FROM ${BASE_IMAGE} AS genesis

FROM genesis AS system

LABEL maintainer="Shikanime Deva <deva.shikanime@protonmail.com>"

# Install essential packages
RUN --mount=type=cache,sharing=private,target=/var/cache/apt --mount=from=genesis,target=/var/lib/apt/lists \
  apt-get update -y && apt-get install -y --no-install-recommends \
  ca-certificates curl git zsh sudo locales file init

# Entrypoint to systemd
CMD [ "/sbin/init" ]

# Setup locales
COPY etc/locale.gen /etc/locale.gen
RUN locale-gen
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en

FROM system AS base

# Create user space
RUN adduser --disabled-password --shell /usr/bin/zsh --gecos "Sakamoto" sakamoto

# Grant user sudo
COPY etc/sudoers.d/sakamoto /etc/sudoers.d/

# Automatic login to user
COPY etc/systemd/system/console-getty.service.d/override.conf /etc/systemd/system/console-getty.service.d/
COPY etc/systemd/system/container-getty@.service.d/override.conf /etc/systemd/system/container-getty@.service.d/

FROM base AS zinit

# Switch to user context
USER sakamoto

# Install Zinit
ARG ZINIT_INSTALL_SCRIPT_URL="https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh"
RUN curl -sSL "${ZINIT_INSTALL_SCRIPT_URL}" | sh

FROM base AS user

# Disable ZSH update
ENV DISABLE_AUTO_UPDATE "true"
ENV DISABLE_UPDATE_PROMPT "true"

# Copy local dependencies
COPY --from=zinit --chown=sakamoto /home/sakamoto/.zinit /home/sakamoto/.zinit

# Add user configuration
COPY --chown=sakamoto home/sakamoto/.zshrc /home/sakamoto/.zshrc
