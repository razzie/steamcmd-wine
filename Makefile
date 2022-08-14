VERSION := `git describe --tags`
IMAGE_NAME := steamcmd-wine
IMAGE_REGISTRY ?= ghcr.io/razzie
FULL_IMAGE_NAME := $(IMAGE_REGISTRY)/$(IMAGE_NAME):$(VERSION)

.PHONY: docker-build-local
docker-build-local:
	docker build . -t $(IMAGE_NAME)

.PHONY: docker-build
docker-build:
	docker build . -t $(FULL_IMAGE_NAME)

.PHONY: docker-push
docker-push: docker-build
	docker push $(FULL_IMAGE_NAME)

.PHONY: docker-push-as-latest
docker-push-as-latest: docker-build
	docker tag $(FULL_IMAGE_NAME) $(IMAGE_REGISTRY)/$(IMAGE_NAME):latest
	docker push $(IMAGE_REGISTRY)/$(IMAGE_NAME):latest
