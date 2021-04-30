# Images registry to be pushed
IMAGE_REGISTRY=docker.pkg.github.com/shikanime/shikanime

# Default Debian base image
PAPERCRAFT_REPOSITORY=$(IMAGE_REGISTRY)/papercraft
PAPERCRAFT_DEBIAN_BASE_IMAGE=debian
PAPERCRAFT_TEXLIVE_BASE_IMAGE=registry.gitlab.com/islandoftex/images/texlive
PAPERCRAFT_TENSORFLOW_BASE_IMAGE=tensorflow/tensorflow

# Multi purpose development image
CATBOX_REPOSITORY=$(IMAGE_REGISTRY)/catbox

# Texlive image
TYPEWRITER_REPOSITORY=$(IMAGE_REGISTRY)/typewriter

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

papercraft-tensorflow-%-image:
	docker buildx build \
		--build-arg BASE_IMAGE="$(PAPERCRAFT_TENSORFLOW_BASE_IMAGE):$*" \
		-t "$(PAPERCRAFT_REPOSITORY):tensorflow-$*" \
		papercraft

catbox-%-image: papercraft-%-image
	docker buildx build \
		--build-arg BASE_IMAGE="$(PAPERCRAFT_REPOSITORY):$*" \
		-t "$(CATBOX_REPOSITORY):$*" \
		catbox

typewriter-%-image: papercraft-%-image
	docker buildx build \
		--build-arg BASE_IMAGE="$(PAPERCRAFT_REPOSITORY):$*" \
		-t "$(TYPEWRITER_REPOSITORY):$*" \
		typewriter
