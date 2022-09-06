
OUTPUT ?= ./public

PROJECTDIR := lektor

ifeq ($(PROJECTDIR),)
$(error Error: pass PROJECTDIR variable with path to Lektor project)
endif

DOCKER_IMAGE := mysite:latest

# below maps '/app' to base directory of the PROJECTDIR project dir
# to mimic how a CI system will be using these commands from a Git repo
# after it's built and is running the custom Dockerfile.
DOCKER_RUN := ./bin/lektor-in-docker "$(DOCKER_IMAGE)"


help:
	@echo "Environment variables:"
	@echo "  DOCKER_IMAGE           The Docker image to use"
	@echo "  DOCKER_RUN             The 'docker run' command to use"
	@echo "  PROJECTDIR             The directory of your Lektor project"
	@echo ""
	@echo "Targets:"
	@echo "  lektor-build"
	@echo "  lektor-server"
	@echo "  lektor-version-freeze"
	@echo "  lektor-deploy"
	@echo "  docker-lektor-build"
	@echo "  docker-lektor-server"
	@echo "  docker-lektor-version-freeze"
	@echo "  docker-build"

lektor-version-freeze:
	cd "$(PROJECTDIR)" \
	&& pip freeze > requirements.txt

lektor-build:
	cd "$(PROJECTDIR)" \
	&& lektor build -v -O "$(OUTPUT)"

lektor-server:
	cd "$(PROJECTDIR)" \
	&& lektor server -h 0.0.0.0

lektor-deploy:
	cd "$(PROJECTDIR)" \
	&& lektor deploy -O "$(OUTPUT)" ghpages-https

docker-lektor-version-freeze: docker-build
	$(DOCKER_RUN) \
		make lektor-version-freeze

docker-lektor-build: docker-build
	$(DOCKER_RUN) \
	    make lektor-build

docker-lektor-server: docker-build
	DOCKER_OPTS="-p 5000:5000" $(DOCKER_RUN) \
	    make lektor-server

docker-build:
	set -eux ; \
	DOCKERFILE="$$(readlink -f Dockerfile)" \
	&& docker build -t $(DOCKER_IMAGE) -f "$$DOCKERFILE" .

