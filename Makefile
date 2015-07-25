
GOPATH  := $(GOPATH):$(shell pwd)/../../../../

define HG_ERROR

FATAL: you need mercurial (hg) to download twine-api dependencies.
       Check README.md for details


endef

define GIT_ERROR

FATAL: you need git to download twine-api dependencies.
       Check README.md for details
endef

define BZR_ERROR

FATAL: you need bazaar (bzr) to download twine-api dependencies.
       Check README.md for details
endef

.PHONY: all check-path get hg git bzr get-code test

all: check-path get test

build: check-path get _go_test _twine-api

# It does not support GOPATH with multiple paths.
check-path:
ifndef GOPATH
	@echo "FATAL: you must declare GOPATH environment variable, for more"
	@echo "       details, please check README.md file and/or"
	@echo "       http://golang.org/cmd/go/#GOPATH_environment_variable"
	@exit 1
endif

	@exit 0

get: hg git bzr get-code godep

hg:
	$(if $(shell hg), , $(error $(HG_ERROR)))

git:
	$(if $(shell git), , $(error $(GIT_ERROR)))

bzr:
	$(if $(shell bzr), , $(error $(BZR_ERROR)))


get-code:
	go get $(GO_EXTRAFLAGS) -u -d -t ./...

godep:
	go get $(GO_EXTRAFLAGS) github.com/tools/godep
	godep restore ./...

build: check-path get _go_test _twine-api

_go_test:
	go clean $(GO_EXTRAFLAGS) ./...
	go test $(GO_EXTRAFLAGS) ./...

_twine-apid:
	rm -f twine-apid
	go build $(GO_EXTRAFLAGS) -o twine-api ./api


_twine-apir:
	sudo ./twine-api start
	rm -f twine-api

#_sh_tests:
#	@conf/trusty/megam/megam_test.sh

test: _go_test _twine-api _twine-apir

_install_deadcode: git
	go get $(GO_EXTRAFLAGS) github.com/remyoudompheng/go-misc/deadcode


deadcode: _install_deadcode
	@go list ./... | sed -e 's;github.com/morpheyesh/twine-api/;;' | xargs deadcode

deadc0de: deadcode
