FROM ubuntu:20.10

LABEL maintainer="deva.shikanime@protonmail.com"

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
	curl https://baltocdn.com/helm/signing.asc | apt-key add - && \
	apt-add-repository -y "deb https://baltocdn.com/helm/stable/debian/ all main"

# Terraform
RUN --mount=type=cache,target=/var/cache/apt --mount=type=cache,target=/var/lib/apt \
	curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - && \
	apt-add-repository -y "deb [arch=amd64] https://apt.releases.hashicorp.com focal main"

# Add Terraform APT keys
RUN --mount=type=cache,target=/var/cache/apt --mount=type=cache,target=/var/lib/apt \
	curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -

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
		default-jdk \
		dialog \
		fop \
		gcc \
		git \
		golang \
		g++ \
		helm \
		htop \
		inotify-tools \
		iproute2 \
		jq \
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

# Haskell development tools
RUN curl -sSL https://get.haskellstack.org/ | sh

# Install Starship
RUN curl -sSL https://starship.rs/install.sh | bash -s -- -y

# Create user space
RUN useradd \
  --user-group \
  --create-home \
  --shell /usr/bin/zsh \
  --groups sudo \
  --comment "Shikanime Deva" \
  devas

# Grant user sudo
COPY etc/sudoers.d/devas /etc/sudoers.d

# Set user environment
WORKDIR /home/devas
USER devas

# Add user configuration
COPY --chown=devas home/devas/.ssh .ssh
COPY --chown=devas home/devas/.gitconfig .gitconfig
COPY --chown=devas home/devas/.gitignore .gitignore
COPY --chown=devas home/devas/.zshrc .zshrc
COPY --chown=devas home/devas/.tool-versions .tool-versions

# Install Oh My ZSH
RUN zsh -i -c "\
	curl -sSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash -s --  --keep-zshrc --skip-chsh"

# Install ASDF
RUN zsh -i -c "\
	git clone https://github.com/asdf-vm/asdf.git .asdf --branch v0.8.0"

# Install ASDF plugins
RUN zsh -i -c "\
	asdf plugin add nodejs && \
	asdf plugin add yarn && \
	asdf plugin add python && \
	asdf plugin add erlang && \
	asdf plugin add cmake && \
	asdf plugin add rebar && \
	asdf plugin add elixir && \
	bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring"

# Install Rust development tools
RUN zsh -i -c "\
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y"

# Install Google Cloud tools
RUN zsh -i -c "\
	curl https://sdk.cloud.google.com | bash -s -- --disable-prompts"
RUN zsh -i -c "\
	gcloud components install --quiet \
		beta \
		alpha \
		kubectl \
		skaffold \
		kustomize"

# Install Krew package manager
RUN mkdir -p /tmp/krew-install && \
  cd /tmp/krew-install && \
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.tar.gz" && \
  tar zxvf krew.tar.gz ./krew-linux_amd64 && \
  ./krew-linux_amd64 install krew && \
  rm -rf /tmp/krew-install

# Command entrypoint
ENTRYPOINT [ "/usr/bin/zsh" ]
