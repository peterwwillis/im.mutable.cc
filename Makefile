DOCKER_IMAGE_NAME = mysite
DOCKER_IMAGE_TAG = latest

JEKYLL_VERSION = 4.2.2


jekyll-gemfile-update-local:
	docker run --rm -it -v "$$(pwd):/srv/jekyll:Z" $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG) bundle update

docker-build:
	docker build -t $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG) .
