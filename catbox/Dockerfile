FROM ubuntu:20.10 as system

LABEL maintainer="Shikanime Deva <deva.shikanime@protonmail.com>"

# Setup timezone
COPY etc/timezone /etc/timezone
COPY etc/localtime /etc/localtime

# Update APT source list
RUN --mount=type=cache,target=/var/cache/apt --mount=type=cache,target=/var/lib/apt \
  apt-get update -y

# Install essential packages
RUN --mount=type=cache,target=/var/cache/apt --mount=type=cache,target=/var/lib/apt \
  apt-get install -y --no-install-recommends \
  ca-certificates \
  curl \
  gnupg2 \
  software-properties-common

# Add Helm APT keys
RUN --mount=type=cache,target=/var/cache/apt --mount=type=cache,target=/var/lib/apt \
  curl https://baltocdn.com/helm/signing.asc | apt-key add - \
  && apt-add-repository -y "deb https://baltocdn.com/helm/stable/debian/ all main"

# Add Terraform APT keys
RUN --mount=type=cache,target=/var/cache/apt --mount=type=cache,target=/var/lib/apt \
  curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - \
  && apt-add-repository -y "deb [arch=amd64] https://apt.releases.hashicorp.com focal main"

# Add Gcloud SDK APT keys
RUN --mount=type=cache,target=/var/cache/apt --mount=type=cache,target=/var/lib/apt \
  curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
  && apt-add-repository -y "deb https://packages.cloud.google.com/apt cloud-sdk main"

# Setup locales
RUN --mount=type=cache,target=/var/cache/apt --mount=type=cache,target=/var/lib/apt \
  apt-get install -y --no-install-recommends \
  locales
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Install common packages
RUN --mount=type=cache,target=/var/cache/apt --mount=type=cache,target=/var/lib/apt \
  apt-get install -y --no-install-recommends \
  apt-transport-https \
  autoconf \
  automake \
  buildah \
  clang-format \
  clang-tidy \
  clang-tools \
  clang \
  darcs \
  default-jdk \
  dialog \
  fop \
  gcc \
  git \
  golang \
  google-cloud-sdk-anthos-auth \
  google-cloud-sdk-app-engine-python \
  google-cloud-sdk-config-connector \
  google-cloud-sdk-kpt \
  google-cloud-sdk-kubectl-oidc \
  google-cloud-sdk-pubsub-emulator \
  google-cloud-sdk-skaffold \
  google-cloud-sdk \
  g++ \
  helm \
  htop \
  inotify-tools \
  iproute2 \
  jq \
  kubectl \
  less \
  libbz2-dev \
  libc6-dev \
  libclang-dev \
  libclang1 \
  libc++-dev \
  libc++1 \
  libc++abi-dev \
  libc++abi1 \
  libffi-dev \
  libgcc1 \
  libgl1-mesa-dev \
  libglu1-mesa-dev \
  libgmp-dev \
  libgssapi-krb5-2 \
  libicu-dev \
  libkrb5-3 \
  liblttng-ust0 \
  libncurses-dev \
  libncurses5-dev \
  libomp-dev \
  libomp5 \
  libpng-dev \
  libreadline-dev \
  libsqlite3-dev \
  libssh-dev \
  libssl-dev \
  libstdc++6 \
  libtool \
  libwxgtk3.0-gtk3-dev \
  libxml2-utils \
  libxslt1-dev \
  libyaml-dev \
  lld \
  lldb \
  llvm-dev \
  llvm-runtime \
  llvm \
  lsb-release \
  lsof \
  m4 \
  make \
  man-db \
  mercurial \
  mesa-utils \
  nano \
  ncdu \
  neovim \
  net-tools \
  netbase \
  ninja-build \
  opam \
  openssh-client \
  podman \
  procps \
  psmisc \
  rsync \
  runc \
  software-properties-common \
  strace \
  sudo \
  terraform \
  texlive \
  unixodbc-dev \
  unzip \
  vim-tiny \
  wget \
  xorg-dev \
  xsltproc \
  xz-utils \
  zip \
  zlib1g-dev \
  zsh

# Java Home
ENV JAVA_HOME /usr/lib/jvm/default-java

# Command entrypoint
ENTRYPOINT [ "/usr/bin/zsh" ]

FROM system as starship

# Install Starship
RUN curl -sSL https://starship.rs/install.sh | bash -s -- -y

FROM system as stack

# Haskell development tools
RUN curl -sSL https://get.haskellstack.org/ | sh

FROM system as base

# Copy external software
COPY --from=starship /usr/local/bin/starship /usr/local/bin/starship
COPY --from=stack /usr/local/bin/stack /usr/local/bin/stack

# Create user space
RUN useradd --user-group --create-home --shell /usr/bin/zsh --groups sudo --comment "Shikanime Deva" devas

# Grant user sudo
COPY etc/sudoers.d/devas /etc/sudoers.d

# Switch to user context
WORKDIR /home/devas
USER devas

FROM base as opam

# Init user OPAM
RUN zsh -i -c "opam init --bare -a -n"

FROM base as rustup

# Install Rust development tools
RUN zsh -i -c "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y"

FROM base as ohmyzsh

# Install Oh My ZSH
RUN zsh -i -c "curl -sSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash -s --  --keep-zshrc --skip-chsh"

FROM base as krew

# Install Krew package manager
RUN mkdir -p /tmp/krew-install \
  && cd /tmp/krew-install \
  && curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.tar.gz" \
  && tar zxvf krew.tar.gz ./krew-linux_amd64 \
  && ./krew-linux_amd64 install krew \
  && rm -rf /tmp/krew-install

FROM base as asdf

# Install ASDF
RUN zsh -i -c "git clone https://github.com/asdf-vm/asdf.git .asdf --branch v0.8.0"

FROM base as user

# Create default SSH directory
RUN mkdir -p .ssh

# Copy local dependencies
COPY --from=ohmyzsh --chown=devas home/devas/.oh-my-zsh .oh-my-zsh
COPY --from=opam --chown=devas home/devas/.opam .opam
COPY --from=asdf --chown=devas /home/devas/.asdf .asdf
COPY --from=rustup --chown=devas /home/devas/.cargo .cargo
COPY --from=rustup --chown=devas /home/devas/.rustup .rustup
COPY --from=krew --chown=devas /home/devas/.krew .krew

# Add user configuration
COPY --chown=devas home/devas/.gitconfig .gitconfig
COPY --chown=devas home/devas/.gitignore .gitignore
COPY --chown=devas home/devas/.zshrc .zshrc

FROM user as asdf-full

# Install ASDF plugins
RUN zsh -i -c "asdf plugin add nodejs \
  && asdf plugin add yarn \
  && asdf plugin add python \
  && asdf plugin add erlang \
  && asdf plugin add cmake \
  && asdf plugin add rebar \
  && asdf plugin add elixir \
  && bash .asdf/plugins/nodejs/bin/import-release-team-keyring"

FROM user

COPY --from=asdf-full --chown=devas /home/devas/.asdf .asdf
