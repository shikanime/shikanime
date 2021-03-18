FROM docker.pkg.github.com/shikanime/shikanime/catbox:v0.3 AS base

# Switch to root user for system installation
USER root

# Default JRE man requirement
RUN mkdir -p /usr/share/man/man1

# Install essential packages
RUN --mount=type=cache,target=/var/cache/apt \
  apt-get update -y && apt-get install -y --no-install-recommends \
  autoconf libncurses-dev build-essential m4 unixodbc-dev \
  libssl-dev libwxgtk3.0-gtk3-dev libglu-dev libncurses5-dev \
  libxml2-utils fop xsltproc g++ man default-jdk

# Switch to user land
USER sakamoto

FROM base

# Add ASDF Erlang/Elixir and Java dependency plugin
RUN asdf plugin-add erlang \
  && asdf plugin-add elixir
