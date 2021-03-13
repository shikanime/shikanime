# Images registry to be pushed
IMAGE_REGISTRY=docker.pkg.github.com/shikanime/shikanime

# Default Debian base image
BASE_REPOSITORY=$(IMAGE_REGISTRY)/base
BASE_IMAGE=$(BASE_REPOSITORY):v0.3

# Multi purpose development image
CATBOX_REPOSITORY=$(IMAGE_REGISTRY)/catbox
CATBOX_IMAGE=$(CATBOX_REPOSITORY):v0.3

# Texlive image
CATEX_BASE_IMAGE=texlive/texlive
CATEX_REPOSITORY=$(IMAGE_REGISTRY)/catex
CATEX_IMAGE=$(CATEX_REPOSITORY):v0.3

all: base-image catbox-image catex-image

base-image:
	docker buildx build -t "$(BASE_IMAGE)" base

catbox-image: base-image
	docker buildx build -t "$(CATBOX_IMAGE)" catbox

catex-image: catex-base-image
	docker buildx build -t "$(CATEX_IMAGE)" catex

catex-base-image:
	docker buildx build --build-arg BASE_IMAGE="$(CATEX_BASE_IMAGE)" -t "$(CATEX_IMAGE)-base" base
