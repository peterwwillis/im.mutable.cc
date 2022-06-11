DOCKER_IMAGE_NAME = mysite
DOCKER_IMAGE_TAG = latest

help:
	@echo "Makefile targets:"
	@echo "  docker-build"

docker-build:
	docker build -t $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG) .
