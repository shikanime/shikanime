ARG BASE_IMAGE
FROM ${BASE_IMAGE} AS genesis

FROM genesis

# Install Python dependencies
RUN --mount=type=cache,sharing=private,target=/var/cache/apt --mount=from=genesis,target=/var/lib/apt/lists \
  apt-get update -y && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  libbz2-dev libsqlite3-dev libssl-dev libreadline-dev liblzma-dev\
  libncursesw5-dev libgdbm-dev libc6-dev zlib1g-dev tk-dev \
  libssl-dev openssl libffi-dev gcc g++ make
