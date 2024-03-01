
# Makefile for building zones
MAKEPWD:=$(dir $(realpath $(firstword $(MAKEFILE_LIST))))
ZONEPATH?=${MAKEPWD}/zones
VERSION:=
DOIT?=""

.PHONY: all
all:
	@echo Use the 'release' target to build released zones.
	@echo "VERSION=$(VERSION)"

.PHONY: release
ifeq ($(VERSION),)
	$(error "Please specify a version use. Use VERSION=[internal|external]")
endif
release: decrypt build

.PHONY: decrypt
decrypt:

ifeq (, $(shell which yq))
    $(error "No yq in $$PATH, please install")
endif

ifeq (, $(shell which sops))
    $(error "No sops in $$PATH, please install")
endif

	@scripts/decrypt-private.sh

.PHONY: build
build:
ifeq (, $(shell which octodns-sync))
    $(error "No octodns-sync in $$PATH, please install")
endif

ifeq ($(VERSION),)
	$(error "Please specify a version use. Use VERSION=[internal|external]")
endif

	octodns-sync --config-file zones/$(VERSION).yaml


# ==================================================================================== #
# HELPERS
# ==================================================================================== #

## clean: cleans up files
clean:
	@echo 'Removing compiled zonefiles'
	@scripts/clean.sh
	@scripts/clean-private.sh

## fresh: cleans up files from previous builds and runs
fresh: clean all

## help: print this help message
.PHONY: help
help:
	@echo 'Usage:'
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'
