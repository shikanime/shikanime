# Images registry to be pushed
IMAGE_REGISTRY=docker.pkg.github.com/shikanime/shikanime

# Default Debian base image
PAPERCRAFT_REPOSITORY=$(IMAGE_REGISTRY)/papercraft
PAPERCRAFT_IMAGE=$(PAPERCRAFT_REPOSITORY):v0.3
PAPERCRAFT_TEXLIVE_BASE_IMAGE=texlive/texlive
PAPERCRAFT_TENSORFLOW_BASE_IMAGE=tensorflow/tensorflow:2.4.1-gpu

# Multi purpose development image
CATBOX_REPOSITORY=$(IMAGE_REGISTRY)/catbox
CATBOX_IMAGE=$(CATBOX_REPOSITORY):v0.3

# Texlive image
TYPEWRITER_REPOSITORY=$(IMAGE_REGISTRY)/typewriter
TYPEWRITER_IMAGE=$(TYPEWRITER_REPOSITORY):v0.3

all: papercraft-image catbox-image typewriter-image

papercraft-image:
	docker buildx build -t "$(PAPERCRAFT_IMAGE)" papercraft

papercraft-texlive-image:
	docker buildx build --build-arg BASE_IMAGE="$(PAPERCRAFT_TEXLIVE_BASE_IMAGE)" -t "$(PAPERCRAFT_IMAGE)-texlive" papercraft

papercraft-tensorflow-image:
	docker buildx build --build-arg BASE_IMAGE="$(PAPERCRAFT_TENSORFLOW_BASE_IMAGE)" -t "$(PAPERCRAFT_IMAGE)-tensorflow-2.4.1-gpu" papercraft

catbox-image: papercraft-image
	docker buildx build -t "$(CATBOX_IMAGE)" catbox

typewriter-image: papercraft-texlive-image
	docker buildx build -t "$(TYPEWRITER_IMAGE)" typewriter
