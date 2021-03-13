FROM texlive/texlive AS system

RUN --mount=type=cache,target=/var/cache/apt \
  --mount=from=debian:bullseye-20210111-slim,target=/var/lib/apt/lists \
  apt-get update -y && apt-get install -y --no-install-recommends \
  zsh curl vim cpanminus make gcc libc6-dev

# Command entrypoint
ENTRYPOINT [ "/bin/zsh", "-c" ]

FROM system AS starship

# Install Starship
ARG STARSHIP_INSTALL_SCRIPT_URL="https://starship.rs/install.sh"
RUN curl -sSL "${STARSHIP_INSTALL_SCRIPT_URL}" | bash -s -- -y

FROM system AS base

# Latex indent logger
RUN cpan -i Log::Log4perl Log::Dispatch::File YAML::Tiny \
  File::HomeDir Unicode::GCString

# Create application user
RUN adduser \
  --disabled-password \
  --gecos "vscode" \
  --shell "/bin/zsh" \
  vscode

# Switch to user context
WORKDIR /home/vscode
USER vscode

FROM base AS ohmyzsh

# Install Oh My ZSH
ARG OH_MY_ZSH_INSTALL_SCRIPT_URL="https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
RUN zsh -i -c "curl -sSL "${OH_MY_ZSH_INSTALL_SCRIPT_URL}" | bash -s --  --keep-zshrc --skip-chsh"

FROM base AS user

# Copy local dependencies
COPY --from=starship --chown=vscode /usr/local/bin/starship .local/bin/starship
COPY --from=ohmyzsh --chown=vscode /home/vscode/.oh-my-zsh .oh-my-zsh

# Add user configuration
COPY --chown=vscode home/vscode/.zshrc .zshrc
