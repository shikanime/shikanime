ARG BASE_IMAGE
FROM ${BASE_IMAGE} AS genesis

FROM genesis AS system

LABEL maintainer="Shikanime Deva <deva.shikanime@protonmail.com>"

# Install TensorRT if not building for PowerPC
ARG CUDA_VERSION
ARG LIBNVINFER_VERSION
ARG LIBNVINFER_MAJOR_VERSION
RUN --mount=type=cache,sharing=private,target=/var/cache/apt --mount=from=genesis,target=/var/lib/apt/lists \
  apt-get update -y && apt-get install -y --no-install-recommends \
  libnvinfer${LIBNVINFER_MAJOR_VERSION}=${LIBNVINFER_VERSION}+cuda${CUDA_VERSION} \
  libnvinfer-plugin${LIBNVINFER_MAJOR_VERSION}=${LIBNVINFER_VERSION}+cuda${CUDA_VERSION}
