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

all: \
	papercraft-debian-bullseye-20210111-image \
	papercraft-texlive-TL2021-2021-04-25-04-10-image \
	papercraft-tensorflow-2.4.1-gpu-image \
	catbox-debian-bullseye-20210111-image \
	typewriter-texlive-TL2021-2021-04-25-04-10-image

papercraft-debian-bullseye-20210111-image:
	docker buildx build \
		--build-arg BASE_IMAGE="$(PAPERCRAFT_DEBIAN_BASE_IMAGE):bullseye-20210111" \
		-t "$(PAPERCRAFT_REPOSITORY):0.3.1-debian-bullseye-20210111" \
		papercraft

papercraft-texlive-TL2021-2021-04-25-04-10-image:
	docker buildx build \
		--build-arg BASE_IMAGE="$(PAPERCRAFT_TEXLIVE_BASE_IMAGE):TL2021-2021-04-25-04-10" \
		-t "$(PAPERCRAFT_REPOSITORY):0.3.1-texlive-TL2021-2021-04-25-04-10" \
		papercraft

papercraft-tensorflow-2.4.1-gpu-image:
	docker buildx build \
		--build-arg BASE_IMAGE="$(PAPERCRAFT_TENSORFLOW_BASE_IMAGE):2.4.1-gpu" \
		-t "$(PAPERCRAFT_REPOSITORY):0.3.1-tensorflow-2.4.1-gpu" \
		papercraft

catbox-debian-bullseye-20210111-image: papercraft-debian-bullseye-20210111-image
	docker buildx build \
		--build-arg BASE_IMAGE="$(PAPERCRAFT_REPOSITORY):0.3.1-debian-bullseye-20210111" \
		-t "$(CATBOX_REPOSITORY):0.3.1-debian-bullseye-20210111" \
		catbox

typewriter-texlive-TL2021-2021-04-25-04-10-image: papercraft-texlive-TL2021-2021-04-25-04-10-image
	docker buildx build \
		--build-arg BASE_IMAGE="$(PAPERCRAFT_REPOSITORY):0.3.1-debian-bullseye-20210111" \
		-t "$(TYPEWRITER_REPOSITORY):0.3.1-texlive-TL2021-2021-04-25-04-10" \
		typewriter
