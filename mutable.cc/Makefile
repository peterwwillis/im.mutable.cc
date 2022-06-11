DOCKER_IMAGE := mysite:latest

DOCKER_RUN := docker run --rm -it -p 5000:5000 -u "$$(id -u):$$(id -g)" -v /etc/passwd:/etc/passwd:ro -v /etc/group:/etc/group:ro -v "$$(pwd):/app:Z" $(DOCKER_IMAGE)

help:
	@echo "Environment variables:"
	@echo "  DOCKER_IMAGE           The Docker image to use"
	@echo "  DOCKER_RUN             The 'docker run' command to use"
	@echo ""
	@echo "Targets:"
	@echo "  lektor-build"
	@echo "  lektor-server"
	@echo "  docker-lektor-build"
	@echo "  docker-lektor-server"
	@echo "  docker-build"

lektor-build:
	lektor build -v -O ./public

docker-lektor-build: docker-build
	$(DOCKER_RUN) \
	    lektor build -v -O ./public

docker-lektor-server: docker-build
	$(DOCKER_RUN) \
		lektor server -h 0.0.0.0

docker-build:
	docker build -t $(DOCKER_IMAGE) .
