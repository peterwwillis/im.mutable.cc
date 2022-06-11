DOCKER_IMAGE_NAME = mysite
DOCKER_IMAGE_TAG = latest

JEKYLL_VERSION = latest


jekyll-gemfile-update-local:
	docker run --rm -it -v "$$(pwd):/srv/jekyll:Z" jekyll/jekyll:$(JEKYLL_VERSION) bundle update

docker-build:
	docker build -t $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG) .
