
ifeq ($(WEBSITE),)
$(error Error: pass WEBSITE variable with path to Lektor project)
endif

WEBSITE_BASEDIR := $(shell dirname "$(WEBSITE)")

DOCKER_IMAGE := mysite:latest

# below maps '/app' to base directory of the website project dir
# to mimic how a CI system will be using these commands from a Git repo
# after it's built and is running the custom Dockerfile.
DOCKER_RUN := docker run --rm -it \
			  	-u "$$(id -u):$$(id -g)" \
				-v /etc/passwd:/etc/passwd:ro -v /etc/group:/etc/group:ro \
				-v "$$(readlink -f "$(WEBSITE_BASEDIR)"):/app:Z"



help:
	@echo "Environment variables:"
	@echo "  DOCKER_IMAGE           The Docker image to use"
	@echo "  DOCKER_RUN             The 'docker run' command to use"
	@echo "  WEBSITE                The directory of your Lektor project website. Required"
	@echo ""
	@echo "Targets:"
	@echo "  lektor-build"
	@echo "  lektor-server"
	@echo "  docker-lektor-build"
	@echo "  docker-lektor-server"
	@echo "  docker-build"

lektor-build:
	cd "$(WEBSITE)" \
	&& lektor build -v -O ./public

lektor-server:
	cd "$(WEBSITE)" \
	&& lektor server -h 0.0.0.0

docker-lektor-build: docker-build
	$(DOCKER_RUN) -e WEBSITE $(DOCKER_IMAGE) \
	    make lektor-build

docker-lektor-server: docker-build
	$(DOCKER_RUN) -e WEBSITE -p 5000:5000 $(DOCKER_IMAGE) \
	    make lektor-server

docker-build:
	set -eux ; \
	DOCKERFILE="$$(readlink -f Dockerfile)" \
	&& cd $(WEBSITE) \
	&& docker build -t $(DOCKER_IMAGE) -f "$$DOCKERFILE" .
