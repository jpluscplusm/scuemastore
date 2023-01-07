# CUE module `jonathanmatthews.com/x/schemastore.org`

This repo takes the JSONSchema documents that are maintained by the excellent [schemastore](https://www.schemastore.org/json/) project, and curates a CUE import of a select subset of their schemas. Please open Issues and/or PRs to expand this set.

## Usage

**This repository MUST be `git clone`d as `https://jonathanmatthews.com/x/schemastore.org`**, despite (currently) being hosted on GitHub. If cloned directly (e.g. via GitHub URI), tests *will not pass*. It should be referenced, in CUE, as `jonathanmatthews.com/x/schemastore.org`.

(This repository uses a git submodule, but you should NOT initialise it. **You do *NOT* need to initialise this submodule when using this repository as a CUE module, or for validating your existing files.** The submodule is only used by the process which imports the upstream JSONSchema documents *into* this module. Unless you are working on importing new upstream documents, you do not need the submodule's contents. Initialising the submodule will only take up disk space, uselessly.)

Add the repo to your `cue.mod` directory, as so:

```
cd cue.mod/pkg
git clone https://jonathanmatthews.com/x/schemastore.org
```

Then use the schemas in your .cue files like this:

```
package p

import "jonathanmatthews.com/x/schemastore.org/github/actions/workflow"

my_gha_workflow: workflow & {
	... // your workflow details here
}
```

### Validation of existing non-CUE files

You can use `cue vet` to check non-CUE files against these CUE-based schema definitions.

Run `cue vet -c` aginst the glob `path/to/definitions/schemastore*.cue`:

```
git clone https://jonathanmatthews.com/x/schemastore.org
cue vet -c schemastore.org/github/actions/workflow/schemastore*.cue path/to/my/github/actions/workflows/*.yml
```

## The `/x/` is for "experimental"

This module is not yet stable. So long as there is a `/x/` in the path, structural and other backwards-incompatible changes might happen to the module's contents.

You should only use it if you are either able to (a) embed a static version of this module or (b) fix things that break in your code because of changes.

This module is aiming for stablity, over time, but can't yet deliver it.

The `/x/` is your reminder of this.

## Expanding and improving the imported schemas

[FIXME]
