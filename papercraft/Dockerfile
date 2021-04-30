ARG BASE_IMAGE=debian
FROM ${BASE_IMAGE} AS genesis

FROM genesis AS system

LABEL maintainer="Shikanime Deva <deva.shikanime@protonmail.com>"

# Enfore root user for system installation
USER root

# Install essential packages
RUN --mount=type=cache,target=/var/cache/apt --mount=from=genesis,target=/var/lib/apt/lists \
  apt-get update -y && apt-get install -y --no-install-recommends \
  ca-certificates curl gnupg2 bash zsh git vim sudo locales ssh

# Setup locales
COPY etc/locale.gen /etc/locale.gen
RUN locale-gen
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en

# Override default shell
SHELL [ "/usr/bin/zsh", "-i", "-c"]
ENTRYPOINT [ "/usr/bin/zsh", "-i" ]

FROM system AS starship

# Install Starship
ARG STARSHIP_INSTALL_SCRIPT_URL="https://starship.rs/install.sh"
RUN curl -sSL "${STARSHIP_INSTALL_SCRIPT_URL}" | bash -s -- -y

FROM system AS base

# Create user space
RUN adduser --disabled-password --shell /usr/bin/zsh --gecos "Sakamoto" sakamoto

# Grant user sudo
COPY etc/sudoers.d/sakamoto /etc/sudoers.d

# Switch to user context
WORKDIR /home/sakamoto
USER sakamoto

FROM base AS ohmyzsh

# Install Oh My ZSH
ARG OH_MY_ZSH_INSTALL_SCRIPT_URL="https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
RUN curl -sSL "${OH_MY_ZSH_INSTALL_SCRIPT_URL}" | bash -s --  --keep-zshrc --skip-chsh

FROM base AS user

# Copy local dependencies
COPY --from=starship --chown=sakamoto /usr/local/bin/starship .local/bin/starship
COPY --from=ohmyzsh --chown=sakamoto /home/sakamoto/.oh-my-zsh .oh-my-zsh

# Add user configuration
COPY --chown=sakamoto home/sakamoto/.gitconfig .gitconfig
COPY --chown=sakamoto home/sakamoto/.gitignore .gitignore
COPY --chown=sakamoto home/sakamoto/.zshrc .zshrc
