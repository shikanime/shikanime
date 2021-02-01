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
RUN curl -sSL https://starship.rs/install.sh | bash -s -- -y

FROM system as stack

# Haskell development tools
RUN curl -sSL https://get.haskellstack.org/ | sh

FROM system AS base

# Create user space
RUN adduser --disabled-password --shell /bin/zsh --gecos "Code" code

# Grant user sudo
COPY etc/sudoers.d/code /etc/sudoers.d

# Switch to user context
WORKDIR /home/code
USER code

FROM base as rustup

# Install Rust development tools
RUN zsh -i -c "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain none"

FROM base AS ohmyzsh

# Install Oh My ZSH
RUN zsh -i -c "curl -sSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash -s --  --keep-zshrc --skip-chsh"

FROM base AS asdf

# Install ASDF
RUN zsh -i -c "git clone https://github.com/asdf-vm/asdf.git .asdf --branch v0.8.0"

FROM base as krew

# Install Krew package manager
RUN mkdir -p /tmp/krew-install \
  && cd /tmp/krew-install \
  && curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.tar.gz" \
  && tar zxvf krew.tar.gz ./krew-linux_amd64 \
  && ./krew-linux_amd64 install krew \
  && rm -rf /tmp/krew-install

FROM base AS user

# Copy local dependencies
COPY --from=starship --chown=code /usr/local/bin/starship .local/bin/starship
COPY --from=stack --chown=code /usr/local/bin/stack .local/bin/stack
COPY --from=ohmyzsh --chown=code /home/code/.oh-my-zsh .oh-my-zsh
COPY --from=asdf --chown=code /home/code/.asdf .asdf
COPY --from=rustup --chown=code /home/code/.cargo .cargo
COPY --from=rustup --chown=code /home/code/.rustup .rustup
COPY --from=krew --chown=code /home/code/.krew .krew

# Add user configuration
COPY --chown=code home/code/.gitconfig .gitconfig
COPY --chown=code home/code/.gitignore .gitignore
COPY --chown=code home/code/.zshrc .zshrc
