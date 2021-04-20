GO=go
GOOS=$(shell go env GOOS)
GOARCH=$(shell go env GOARCH)
GO_LDFLAGS=-ldflags="-s -w"
TARGET_DIR=bin/

.PHONY: build test clean scmp-gen

build:
	mkdir -p bin
	GOOS=$(GOOS) GO_ARCH=$(GOARCH) $(GO) build $(GO_LDFLAGS) -o $(TARGET_DIR) ./...

test:
	$(GO) test -v ./...

clean:
	rm -rf bin .target

scmp-gen:
	mkdir -p .target
	GOOS=$(GOOS) GO_ARCH=$(GOARCH) $(GO) build -o .target ./...
	sprofiler -b .target/sprofiler-demo-app -o seccomp-profile.app.json
