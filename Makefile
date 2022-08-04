.PHONY: clean build

export DOCKER_IMAGE_VERSION=1.0.0
export DOCKER_IMAGE_REGESTRY=unstablectrl/app
export DOCKER_BUILDKIT=1

clean:
	@docker system prune -a -f
	@# docker image rm unstablectrl/app:builder unstablectrl/app:latest unstablectrl/app:1.0.0 -f
	@# docker image prune -f

build: clean
	@./build.sh
