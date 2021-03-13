FROM debian:bullseye-20210111-slim AS system

LABEL maintainer="Shikanime Deva <deva.shikanime@protonmail.com>"

# Setup timezone
COPY etc/timezone /etc/timezone
COPY etc/localtime /etc/localtime

# Install essential packages
RUN --mount=type=cache,target=/var/cache/apt --mount=from=debian:bullseye-20210111-slim,target=/var/lib/apt/lists \
  apt-get update -y && apt-get install -y --no-install-recommends \
  ca-certificates curl gnupg2 bash zsh git vim sudo gcc g++ make \
  libc6-dev libffi-dev libgmp-dev zlib1g-dev xz-utils netbase

# Command entrypoint
ENTRYPOINT [ "/bin/zsh" ]

FROM system AS starship

# Install Starship
ARG STARSHIP_INSTALL_SCRIPT_URL="https://starship.rs/install.sh"
RUN curl -sSL "${STARSHIP_INSTALL_SCRIPT_URL}" | bash -s -- -y

FROM system as stack

# Haskell development tools
ARG STACK_INSTALL_SCRIPT_URL="https://get.haskellstack.org"
RUN curl -sSL "${STACK_INSTALL_SCRIPT_URL}" | sh

FROM system AS base

# Create user space
RUN adduser --disabled-password --shell /bin/zsh --gecos "Code" vscode

# Grant user sudo
COPY etc/sudoers.d/vscode /etc/sudoers.d

# Switch to user context
WORKDIR /home/vscode
USER vscode

FROM base as rustup

# Install Rust development tools
ARG RUSTUP_INSTALL_SCRIPT_URL="https://sh.rustup.rs"
RUN zsh -i -c "curl --proto '=https' --tlsv1.2 -sSf "${RUSTUP_INSTALL_SCRIPT_URL}" | sh -s -- -y --default-toolchain none"

FROM base AS ohmyzsh

# Install Oh My ZSH
ARG OH_MY_ZSH_INSTALL_SCRIPT_URL="https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
RUN zsh -i -c "curl -sSL $"{OH_MY_ZSH_INSTALL_SCRIPT_URL}" | bash -s --  --keep-zshrc --skip-chsh"

FROM base AS asdf

# Install ASDF
ARG ASDF_REPOSITORY="https://github.com/asdf-vm/asdf.git"
RUN zsh -i -c "git clone "${ASDF_REPOSITORY}" .asdf --branch v0.8.0"

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
COPY --from=starship --chown=vscode /usr/local/bin/starship .local/bin/starship
COPY --from=stack --chown=vscode /usr/local/bin/stack .local/bin/stack
COPY --from=ohmyzsh --chown=vscode /home/vscode/.oh-my-zsh .oh-my-zsh
COPY --from=asdf --chown=vscode /home/vscode/.asdf .asdf
COPY --from=rustup --chown=vscode /home/vscode/.cargo .cargo
COPY --from=rustup --chown=vscode /home/vscode/.rustup .rustup
COPY --from=krew --chown=vscode /home/vscode/.krew .krew

# Add user configuration
COPY --chown=vscode home/vscode/.gitconfig .gitconfig
COPY --chown=vscode home/vscode/.gitignore .gitignore
COPY --chown=vscode home/vscode/.zshrc .zshrc
