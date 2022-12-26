default: help

MAKEFLAGS += --warn-undefined-variables \
	     --no-builtin-rules \
	     --no-builtin-variables \
	     --no-print-directory
ALL:=
VPATH=.build/schemastore-json
DYN=.build/Makefile.dynamic

include $(DYN)
$(DYN): $(wildcard .build/*.cue) # Automatically update the dynamic list of .cue targets
	@echo '# THIS FILE IS AUTOMATICALLY MANAGED & OVERWRITTEN; DO NOT EDIT MANUALLY' >$@
	@cue export --expression dynamic --out text jonathanmatthews.com/x/schemastore.org/.build:makefile >>$@

.PHONY: all
all: $(ALL) ## Create all out-of-date .cue schema files

.PHONY: clean
clean: ## Remove all .cue schema files, and their containing directories
	@rm -vf $(ALL)
	@rmdir -vp $(sort $(dir $(ALL))) || true
	@rm $(DYN)

%/schema.cue:
	cue import jsonschema: $< --force --outfile $@ --package $(PACKAGE) --path '_#Schema:'
%/embed.cue:
	echo 'package $(PACKAGE)\n\n_#Schema' >$@

.PHONY: help
help: ## Show this help
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
