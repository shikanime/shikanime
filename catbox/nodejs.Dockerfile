ARG BASE_IMAGE
FROM ${BASE_IMAGE} AS genesis

FROM genesis

# Switch to root user for system installation
USER root

# Install essential packages
RUN --mount=type=cache,sharing=locked,target=/var/cache/apt --mount=from=genesis,target=/var/lib/apt/lists \
  apt-get update -y && apt-get install -y --no-install-recommends \
  python3 make g++

# Switch to user land
USER sakamoto
