# ====================================================================================
# Setup Project

ifeq ($(origin FILTER_REGEX_EXCLUDE), undefined)
FILTER_REGEX_EXCLUDE := (?!.*)
endif

ifeq ($(origin DOCKERFILE), undefined)
DOCKERFILE := $(ROOT)/Dockerfile
endif

ifeq ($(origin MAKEFILE), undefined)
MAKEFILE := $(ROOT)/Makefile
endif

ifeq ($(origin MAKEFILE), undefined)
MAKEFILE := $(ROOT)/Makefile
endif

ifneq ($(origin GITHUB_WORKSPACE), undefined)
# Load Github Action Environment
RUN_LOCAL=false
else
RUN_LOCAL=true
endif

ifeq ($(origin DEFAULT_BRANCH), undefined)
DEFAULT_BRANCH := $(shell git rev-parse --abbrev-ref HEAD)
endif

# ====================================================================================
# Actions
.PHONY: linter.superlinter
lint.superlinter: #! Run Super Linter as a static analysis tool to scan the codebase.
	docker run --rm --name=$(PROJECT_NAME)-$(VERSION)-scanner -e SHELL=/bin/bash -e IGNORE_GITIGNORED_FILES=true -e RUN_LOCAL=$(RUN_LOCAL) -e DEFAULT_BRANCH=$(DEFAULT_BRANCH) -e FILTER_REGEX_EXCLUDE="$(FILTER_REGEX_EXCLUDE)" -v $(ROOT):/tmp/lint/ ghcr.io/super-linter/super-linter:v7.0.0

.PHONY: lint.hadolint
lint.hadolint: #! Run Hadolint as a static analysis tool to scan the Dockerfile.
	docker run --rm -i ghcr.io/hadolint/hadolint:v2.12.0-alpine < $(DOCKERFILE)

.PHONY: lint.checkmake
lint.checkmake: #! Run Checkmake as a static analysis tool to scan the Makefile.
	docker run --rm -v $(MAKEFILE):/Makefile mrtazz/checkmake:latest

.PHONY: lint.clean
lint.clean: #! Remove file generate by the linters.
	rm super-linter.log || true
