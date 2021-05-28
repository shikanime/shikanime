ARG BASE_IMAGE
FROM ${BASE_IMAGE} AS genesis

FROM genesis

# Default JRE man requirement
RUN mkdir -p /usr/share/man/man1

# Install essential packages
RUN --mount=type=cache,sharing=private,target=/var/cache/apt --mount=from=genesis,target=/var/lib/apt/lists \
  apt-get update -y && apt-get install -y --no-install-recommends \
  autoconf libncurses-dev build-essential m4 unixodbc-dev \
  libssl-dev libwxgtk3.0-gtk3-dev libglu-dev libncurses5-dev \
  libxml2-utils fop xsltproc g++ man default-jdk
