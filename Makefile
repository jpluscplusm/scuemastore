default: help

MAKEFLAGS += --warn-undefined-variables \
	     --no-builtin-rules \
	     --no-builtin-variables \
	     --no-print-directory
makefile_suffixes += SCHEMASTORE_CUE \
                     generated_files \
		     TESTS

DYNAMIC_MAKEFILES=$(addprefix .build/Makefile., $(makefile_suffixes))
CUE?=cue-0.5.0-beta.2
# We use "cue eval" not "cue vet" while https://github.com/cue-lang/cue/issues/2120 is open
CUETEST=$(CUE) eval >/dev/null
MODULE_ID=jonathanmatthews.com/x/schemastore.org

include $(DYNAMIC_MAKEFILES)

.PHONY: all build import test clean
all: build
build: import test ## Recreate and test all CUE schema files
import: $(SCHEMASTORE_CUE) ## Re/generate all missing or outdated CUE schema files
test: test-unit test-integration ## Run all tests
clean: clean-schemastore-cue clean-makefiles ## Remove all generated CUE files

## Import

VPATH=.build/upstream/src/schemas/json
%/schemastore.cue:
	## Import :: $(PACKAGE_NAME)
	$(CUE) import jsonschema: "$<" --force --outfile "$@" --package $(PACKAGE_NAME) --path '_#Schema:'
%/schemastore-embed.cue:
	## Import :: $(PACKAGE_NAME) embedding
	printf "package %s\n\nclose({\n_#Schema\n})" "$(PACKAGE_NAME)" >"$@"

## Test

.PHONY: test-unit test-integration
test-unit: $(UNIT_TESTS) ## Run unit tests
%/test.unit.cue.run: %/schemastore.cue %/schemastore-embed.cue %/test.unit.cue
	## Test :: Unit :: $(PACKAGE_PATH)
	$(CUETEST) $(MODULE_ID)/$(PACKAGE_PATH):$(TEST_PACKAGE_NAME) -e unit

test-integration: $(INTEGRATION_TESTS) ## Run integration tests 
%/test.integration.cue.run: SHELL=/bin/bash
%/test.integration.cue.run: %/schemastore.cue %/schemastore-embed.cue %/test.integration.cue
	## Test :: Integration :: Positive :: $(PACKAGE_PATH)
	@$(CUE) export $(MODULE_ID)/$(PACKAGE_PATH):$(TEST_PACKAGE_NAME) -e integration.positive --out text \
	| xargs --no-run-if-empty --verbose -I{} \
       		$(CUETEST) "$(PACKAGE_PATH)/schemastore.cue" "$(PACKAGE_PATH)/schemastore-embed.cue" "{}"
	## Test :: Integration :: Negative :: $(PACKAGE_PATH) (schema successfully rejects each test fixture)
	@# This next "line" is evil. Sorry. Replace this whole target with a script! FIXME.
	@# Subtle failure mode: if the cue-export outputs non-existent files, the CUETEST fails, but wrongly. FIXME.
	@# The --concrete was added solely to allow the schema-in-schema-in-schema unist negative tests to succeed. FIXME
	@R=0; while read FIXTURE; do \
	  	( PS4=!\ ; set -x; ! $(CUETEST) --concrete $(PACKAGE_PATH)/schemastore*.cue "$$FIXTURE" 2>&1 ) ;\
		(( R+=$$? )) ;\
	done < <($(CUE) export $(MODULE_ID)/$(PACKAGE_PATH):$(TEST_PACKAGE_NAME) -e integration.negative --out text ) ;\
	exit $$R

## Clean

.PHONY: clean-makefiles clean-schemastore-cue
clean-makefiles: ## Remove all dynamically-generated Makefiles (in ./.build/)
	@rm -vf $(DYNAMIC_MAKEFILES)
clean-schemastore-cue: ## Remove all CUE files generated by importing upstream schemas
	@rm -vf $(SCHEMASTORE_CUE)

## Dynamic makefiles

.build/Makefile.%: .build/data.cue Makefile # automatically update the dynamic list of CUE targets/etc
	@$(CUE) export \
		--force \
		--out text \
		$(MODULE_ID)/.build:makefile \
		--expression Makefile.$* \
		--outfile "$@"

.PHONY: help
help: ## Show this help
	@egrep -h '^[^[:blank:]].*\s##\s' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
