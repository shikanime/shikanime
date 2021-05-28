ARG BASE_IMAGE
FROM ${BASE_IMAGE} AS genesis

FROM genesis AS system

LABEL maintainer="Shikanime Deva <deva.shikanime@protonmail.com>"

# Install system packages
RUN --mount=type=cache,sharing=private,target=/var/cache/apt --mount=from=genesis,target=/var/lib/apt/lists \
  apt-get update -y && apt-get install -y --no-install-recommends \
  curl cpanminus make gcc libc6-dev

FROM system AS base

# Latex indent dependencies
RUN --mount=type=cache,sharing=private,target=/home/root/.cpan \
  cpan -i Log::Log4perl Log::Dispatch::File YAML::Tiny \
  File::HomeDir Unicode::GCString
