FROM docker.pkg.github.com/shikanime/shikanime/catbox:v0.3 AS base

# Switch to root user for system installation
USER root

# Install Python dependencies
RUN --mount=type=cache,target=/var/cache/apt \
  apt-get update -y && apt-get install -y --no-install-recommends \
  libbz2-dev libsqlite3-dev libssl-dev libreadline-dev

# Switch to user land
USER sakamoto

FROM base

# Install ASDF Python plugin
RUN asdf plugin-add python
