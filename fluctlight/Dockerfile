ARG BASE_IMAGE
FROM ${BASE_IMAGE} AS genesis

FROM genesis AS system

LABEL maintainer="Shikanime Deva <deva.shikanime@protonmail.com>"

# Enfore root user for system installation
USER root

# Install TensorRT if not building for PowerPC
# NOTE: libnvinfer uses cuda11.1 versions
ARG LIBNVINFER=7.2.2-1
ARG LIBNVINFER_MAJOR_VERSION=7
RUN --mount=type=cache,target=/var/cache/apt --mount=from=genesis,target=/var/lib/apt/lists \
  apt-get update -y && apt-get install -y --no-install-recommends \
  libnvinfer${LIBNVINFER_MAJOR_VERSION}=${LIBNVINFER}+cuda11.1 \
  libnvinfer-plugin${LIBNVINFER_MAJOR_VERSION}=${LIBNVINFER}+cuda11.1

# For CUDA profiling, TensorFlow requires CUPTI.
ENV LD_LIBRARY_PATH /usr/local/cuda/extras/CUPTI/lib64:/usr/local/cuda/lib64:$LD_LIBRARY_PATH

# Link the libcuda stub to the location where Tensorflow is searching for it and reconfigure
# dynamic linker run-time bindings
RUN ln -s /usr/local/cuda/lib64/stubs/libcuda.so /usr/local/cuda/lib64/stubs/libcuda.so.1 \
  && echo "/usr/local/cuda/lib64/stubs" > /etc/ld.so.conf.d/z-cuda-stubs.conf \
  && ldconfig

FROM system AS user

# Switch to user context
WORKDIR /home/sakamoto
USER sakamoto
