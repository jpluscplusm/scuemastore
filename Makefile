default: help

MAKEFLAGS += --warn-undefined-variables \
	     --no-builtin-rules \
	     --no-builtin-variables \
	     --no-print-directory
ALL:=
VPATH=.build/schemastore-json
DYN=.build/Makefile.dynamic
CUE?=cue-0.5.0-beta.2

include $(DYN)
$(DYN): $(wildcard .build/*.cue) # Automatically update the dynamic list of .cue targets
	@echo '# THIS FILE IS AUTOMATICALLY MANAGED & OVERWRITTEN; DO NOT EDIT MANUALLY' >$@
	@$(CUE) export --expression dynamic --out text jonathanmatthews.com/x/schemastore.org/.build:makefile >>$@

.PHONY: build
build: clean all test ## Rebuild and test all CUE schemas

.PHONY: all
all: $(ALL) ## Create all out-of-date .cue schema files

.PHONY: clean
clean: ## Remove all .cue schema files, and their containing directories
	@rm -vf $(ALL)
	@rmdir -vp $(sort $(dir $(ALL))) || true
	@rm $(DYN)

.PHONY: test
test: ## Run all tests against the CUE corpus
	$(CUE) vet jonathanmatthews.com/x/schemastore.org/.build/tests

%/schema.cue:
	$(CUE) import jsonschema: $< --force --outfile $@ --package $(PACKAGE) --path '_#Schema:'
%/embed.cue:
	echo 'package $(PACKAGE)\n\n_#Schema' >$@

.PHONY: help
help: ## Show this help
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
