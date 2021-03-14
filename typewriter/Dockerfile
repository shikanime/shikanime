ARG BASE_IMAGE=docker.pkg.github.com/shikanime/shikanime/papercraft:v0.3-texlive
FROM ${BASE_IMAGE} AS genesis

FROM genesis AS system

LABEL maintainer="Shikanime Deva <deva.shikanime@protonmail.com>"

# Enfore root user for system installation
USER root

# Install system packages
RUN --mount=type=cache,target=/var/cache/apt --mount=from=genesis,target=/var/lib/apt/lists \
  apt-get update -y && apt-get install -y --no-install-recommends \
  curl cpanminus make gcc libc6-dev

FROM system AS base

# Latex indent dependencies
RUN --mount=type=cache,target=/home/root/.cpan \
  cpan -i Log::Log4perl Log::Dispatch::File YAML::Tiny \
  File::HomeDir Unicode::GCString

FROM base AS user

# Switch to user context
WORKDIR /home/sakamoto
USER sakamoto
