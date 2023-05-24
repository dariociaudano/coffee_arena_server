.PHONY: build clean docker

GO=CGO_ENABLED=0 GO111MODULE=on go
GOCGO=CGO_ENABLED=1 GO111MODULE=on go

MICROSERVICES=coffee_arena_server
.PHONY: $(MICROSERVICES)

DOCKER_TAG=$(VERSION)-dev

GOFLAGS=-ldflags "-X github.com/dariociaudano/coffee_arena_server.Version=$(VERSION)"

GIT_SHA=$(shell git rev-parse HEAD)

ifdef version
	VERSION=$(version)
else
	VERSION=0.0.0
endif

ifdef arch
	ARCH=$(arch)
else
	ARCH=amd64
endif

ifdef os
	OS=$(os)
else
	OS=linux
endif

build: $(MICROSERVICES)
	#$(GOCGO) install -tags=safe

coffee_arena_server:
	go mod tidy
	$(GOCGO) build $(GOFLAGS) -o $@ ./

docker:
	docker buildx build \
		-f docker/Dockerfile \
		-t coffee-arena-server:$(VERSION) \
		--platform=$(OS)/$(ARCH) \
		--build-arg TARGETOS=$(OS) \
		--build-arg TARGETARCH=$(ARCH) \
		.

clean:
	rm -f $(MICROSERVICES)