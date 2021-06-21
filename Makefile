# Images registry to be pushed
IMAGE_REGISTRY=docker.pkg.github.com/shikanime/shikanime

# Default Debian base image
PAPERCRAFT_REPOSITORY=$(IMAGE_REGISTRY)/papercraft
PAPERCRAFT_DEBIAN_BASE_IMAGE=debian
PAPERCRAFT_TEXLIVE_BASE_IMAGE=registry.gitlab.com/islandoftex/images/texlive
PAPERCRAFT_CUDA_BASE_IMAGE=nvidia/cuda

# Multi purpose development image
CATBOX_REPOSITORY=$(IMAGE_REGISTRY)/catbox

# Texlive image
TYPEWRITER_REPOSITORY=$(IMAGE_REGISTRY)/typewriter

# Scientific heavy compute image
FLUCLIGHT_REPOSITORY=$(IMAGE_REGISTRY)/fluctlight

# Global version
VERSION=0.5.1

all:

papercraft-debian-%-image:
	docker buildx build \
		--push \
		--build-arg BASE_IMAGE="$(PAPERCRAFT_DEBIAN_BASE_IMAGE):$*" \
		-t "$(PAPERCRAFT_REPOSITORY):$(VERSION)-debian-$*" \
		papercraft

papercraft-texlive-%-image:
	docker buildx build \
		--push \
		--build-arg BASE_IMAGE="$(PAPERCRAFT_TEXLIVE_BASE_IMAGE):$*" \
		-t "$(PAPERCRAFT_REPOSITORY):$(VERSION)-texlive-$*" \
		papercraft

papercraft-cuda-%-image:
	docker buildx build \
		--push \
		--build-arg BASE_IMAGE="$(PAPERCRAFT_CUDA_BASE_IMAGE):$*" \
		-t "$(PAPERCRAFT_REPOSITORY):$(VERSION)-cuda-$*" \
		papercraft

catbox-%-image: papercraft-%-image
	docker buildx build \
		--push \
		--build-arg BASE_IMAGE="$(PAPERCRAFT_REPOSITORY):$(VERSION)-$*" \
		-t "$(CATBOX_REPOSITORY):$(VERSION)-$*" \
		catbox

catbox-cuda-%-image: papercraft-cuda-%-image
	docker buildx build \
		--push \
		--build-arg BASE_IMAGE="$(PAPERCRAFT_REPOSITORY):$(VERSION)-cuda-$*" \
		-t "$(CATBOX_REPOSITORY):$(VERSION)-cuda-$*" \
		catbox

catbox-python-%-image: catbox-%-image
	docker buildx build \
		--push \
		--build-arg BASE_IMAGE="$(CATBOX_REPOSITORY):$(VERSION)-$*" \
		-t "$(CATBOX_REPOSITORY):$(VERSION)-python-$*" \
		-f catbox/python.Dockerfile \
		catbox

catbox-erlang-%-image: catbox-%-image
	docker buildx build \
		--push \
		--build-arg BASE_IMAGE="$(CATBOX_REPOSITORY):$(VERSION)-$*" \
		-t "$(CATBOX_REPOSITORY):$(VERSION)-erlang-$*" \
		-f catbox/erlang.Dockerfile \
		catbox

catbox-nodejs-%-image: catbox-%-image
	docker buildx build \
		--push \
		--build-arg BASE_IMAGE="$(CATBOX_REPOSITORY):$(VERSION)-$*" \
		-t "$(CATBOX_REPOSITORY):$(VERSION)-nodejs-$*" \
		-f catbox/nodejs.Dockerfile \
		catbox

typewriter-%-image: catbox-%-image
	docker buildx build \
		--push \
		--build-arg BASE_IMAGE="$(CATBOX_REPOSITORY):$(VERSION)-$*" \
		-t "$(TYPEWRITER_REPOSITORY):$(VERSION)-$*" \
		typewriter

fluctlight-%-cuda-11.3.1-tensorrt8-cudnn8-devel-ubuntu18.04-image: fluctlight-%-cuda-11.3.1-cudnn8-devel-ubuntu18.04-image
	docker buildx build \
		--push \
		--build-arg BASE_IMAGE="$(CATBOX_REPOSITORY):$(VERSION)-$*-cuda-11.3.1-cudnn8-devel-ubuntu18.04" \
		--build-arg CUDA_VERSION="11.3" \
		--build-arg LIBNVINFER_VERSION="8.0.0-1" \
		--build-arg LIBNVINFER_MAJOR_VERSION="8" \
		-t "$(FLUCLIGHT_REPOSITORY):$(VERSION)-$*-cuda-11.3.1-tensorrt8-cudnn8-devel-ubuntu18.04" \
		-f fluctlight/tensorrt.Dockerfile \
		fluctlight

fluctlight-%-image: catbox-%-image
	docker buildx build \
		--push \
		--build-arg BASE_IMAGE="$(CATBOX_REPOSITORY):$(VERSION)-$*" \
		-t "$(FLUCLIGHT_REPOSITORY):$(VERSION)-$*" \
		fluctlight
