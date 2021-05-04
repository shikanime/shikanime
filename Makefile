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

all:

papercraft-debian-%-image:
	docker buildx build \
		--build-arg BASE_IMAGE="$(PAPERCRAFT_DEBIAN_BASE_IMAGE):$*" \
		-t "$(PAPERCRAFT_REPOSITORY):debian-$*" \
		papercraft

papercraft-texlive-%-image:
	docker buildx build \
		--build-arg BASE_IMAGE="$(PAPERCRAFT_TEXLIVE_BASE_IMAGE):$*" \
		-t "$(PAPERCRAFT_REPOSITORY):texlive-$*" \
		papercraft

papercraft-cuda-%-image:
	docker buildx build \
		--build-arg BASE_IMAGE="$(PAPERCRAFT_CUDA_BASE_IMAGE):$*" \
		-t "$(PAPERCRAFT_REPOSITORY):cuda-$*" \
		papercraft

catbox-%-image: papercraft-%-image
	docker buildx build \
		--build-arg BASE_IMAGE="$(PAPERCRAFT_REPOSITORY):$*" \
		-t "$(CATBOX_REPOSITORY):$*" \
		catbox

catbox-cuda-%-image: papercraft-cuda-%-image
	docker buildx build \
		--build-arg BASE_IMAGE="$(PAPERCRAFT_REPOSITORY):cuda-$*" \
		-t "$(CATBOX_REPOSITORY):cuda-$*" \
		catbox

typewriter-%-image: papercraft-%-image
	docker buildx build \
		--build-arg BASE_IMAGE="$(PAPERCRAFT_REPOSITORY):$*" \
		-t "$(TYPEWRITER_REPOSITORY):$*" \
		typewriter

fluctlight-%-image: catbox-%-image
	docker buildx build \
		--build-arg BASE_IMAGE="$(CATBOX_REPOSITORY):$*" \
		-t "$(FLUCLIGHT_REPOSITORY):$*" \
		fluctlight
