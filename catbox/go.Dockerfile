ARG BASE_IMAGE
FROM ${BASE_IMAGE} AS genesis

FROM genesis

# Install essential packages
RUN --mount=type=cache,sharing=private,target=/var/cache/apt --mount=from=genesis,target=/var/lib/apt/lists \
  apt-get update -y && apt-get install -y --no-install-recommends \
  gcc unzip libc-dev
