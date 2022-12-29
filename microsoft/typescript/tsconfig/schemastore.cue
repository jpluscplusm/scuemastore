package tsconfig

import "list"

_#Schema: {
	// JSON schema for the TypeScript compiler's configuration file
	@jsonschema(schema="http://json-schema.org/draft-04/schema#")
	#compilerOptionsDefinition & #compileOnSaveDefinition & #typeAcquisitionDefinition & #extendsDefinition & #watchOptionsDefinition & #buildOptionsDefinition & #tsNodeDefinition & ((#filesDefinition | #excludeDefinition | #includeDefinition | #referencesDefinition) & {
		...
	})

	#: "//": _

	#filesDefinition: null | bool | number | string | [...] | {
		// If no 'files' or 'include' property is present in a
		// tsconfig.json, the compiler defaults to including all files in
		// the containing directory and subdirectories except those
		// specified by 'exclude'. When a 'files' property is specified,
		// only those files and those specified by 'include' are
		// included.
		files?: list.UniqueItems() & [...string]
		...
	}

	#excludeDefinition: null | bool | number | string | [...] | {
		// Specifies a list of files to be excluded from compilation. The
		// 'exclude' property only affects the files included via the
		// 'include' property and not the 'files' property. Glob patterns
		// require TypeScript version 2.0 or later.
		exclude?: list.UniqueItems() & [...string]
		...
	}

	#includeDefinition: null | bool | number | string | [...] | {
		// Specifies a list of glob patterns that match files to be
		// included in compilation. If no 'files' or 'include' property
		// is present in a tsconfig.json, the compiler defaults to
		// including all files in the containing directory and
		// subdirectories except those specified by 'exclude'. Requires
		// TypeScript version 2.0 or later.
		include?: list.UniqueItems() & [...string]
		...
	}

	#compileOnSaveDefinition: null | bool | number | string | [...] | {
		// Enable Compile-on-Save for this project.
		compileOnSave?: bool
		...
	}

	#extendsDefinition: null | bool | number | string | [...] | {
		// Path to base configuration file to inherit from (requires
		// TypeScript version 2.1 or later), or array of base files, with
		// the rightmost files having the greater priority (requires
		// TypeScript version 5.0 or later).
		extends?: string | *"" | [...string]
		...
	}

	#buildOptionsDefinition: null | bool | number | string | [...] | {
		buildOptions?: null | bool | number | string | [...] | {
			// ~
			dry?: bool | *false

			// Build all projects, including those that appear to be up to
			// date
			force?: bool | *false

			// Enable verbose logging
			verbose?: bool | *false

			// Save .tsbuildinfo files to allow for incremental compilation of
			// projects.
			incremental?: bool | *false

			// Have recompiles in projects that use `incremental` and `watch`
			// mode assume that changes within a file will only affect files
			// directly depending on it.
			assumeChangesOnlyAffectDirectDependencies?: bool | *false

			// Log paths used during the `moduleResolution` process.
			traceResolution?: bool | *false
			...
		}
		...
	}

	#watchOptionsDefinition: null | bool | number | string | [...] | {
		// Settings for the watch mode in TypeScript.
		watchOptions?: {
			// ~
			force?: string

			// Specify how the TypeScript watch mode works.
			watchFile?: string

			// Specify how directories are watched on systems that lack
			// recursive file-watching functionality.
			watchDirectory?: string

			// Specify what approach the watcher should use if the system runs
			// out of native file watchers.
			fallbackPolling?: string

			// Synchronously call callbacks and update the state of directory
			// watchers on platforms that don`t support recursive watching
			// natively.
			synchronousWatchDirectory?: bool

			// Remove a list of files from the watch mode's processing.
			excludeFiles?: list.UniqueItems() & [...string]

			// Remove a list of directories from the watch process.
			excludeDirectories?: list.UniqueItems() & [...string]
			...
		}
		...
	}

	#compilerOptionsDefinition: null | bool | number | string | [...] | {
		// Instructs the TypeScript compiler how to compile .ts files.
		compilerOptions?: {
			// No longer supported. In early versions, manually set the text
			// encoding for reading files.
			charset?: string

			// Enable constraints that allow a TypeScript project to be used
			// with project references.
			composite?: bool | *true

			// Generate .d.ts files from TypeScript and JavaScript files in
			// your project.
			declaration?: bool | *false

			// Specify the output directory for generated declaration files.
			declarationDir?: null | string

			// Output compiler performance information after building.
			diagnostics?: bool

			// Reduce the number of projects loaded automatically by
			// TypeScript.
			disableReferencedProjectLoad?: bool

			// Enforces using indexed accessors for keys declared using an
			// indexed type
			noPropertyAccessFromIndexSignature?: bool

			// Emit a UTF-8 Byte Order Mark (BOM) in the beginning of output
			// files.
			emitBOM?: bool | *false

			// Only output d.ts files and not JavaScript files.
			emitDeclarationOnly?: bool | *false

			// Differentiate between undefined and not present when type
			// checking
			exactOptionalPropertyTypes?: bool | *false

			// Enable incremental compilation. Requires TypeScript version 3.4
			// or later.
			incremental?: bool

			// Specify the folder for .tsbuildinfo incremental compilation
			// files.
			tsBuildInfoFile?: string | *".tsbuildinfo"

			// Include sourcemap files inside the emitted JavaScript.
			inlineSourceMap?: bool | *false

			// Include source code in the sourcemaps inside the emitted
			// JavaScript.
			inlineSources?: bool | *false

			// Specify what JSX code is generated.
			jsx?: "preserve" | "react" | "react-jsx" | "react-jsxdev" | "react-native"

			// Specify the object invoked for `createElement`. This only
			// applies when targeting `react` JSX emit.
			reactNamespace?: string | *"React"

			// Specify the JSX factory function used when targeting React JSX
			// emit, e.g. 'React.createElement' or 'h'
			jsxFactory?: string | *"React.createElement"

			// Specify the JSX Fragment reference used for fragments when
			// targeting React JSX emit e.g. 'React.Fragment' or 'Fragment'.
			jsxFragmentFactory?: string | *"React.Fragment"

			// Specify module specifier used to import the JSX factory
			// functions when using `jsx: react-jsx`.
			jsxImportSource?: string | *"react"

			// Print all of the files read during the compilation.
			listFiles?: bool | *false

			// Specify the location where debugger should locate map files
			// instead of generated locations.
			mapRoot?: string

			// Specify what module code is generated.
			module?: ("CommonJS" | "AMD" | "System" | "UMD" | "ES6" | "ES2015" | "ES2020" | "ESNext" | "None" | "ES2022" | "Node16" | "NodeNext" | =~"^([Cc][Oo][Mm][Mm][Oo][Nn][Jj][Ss]|[AaUu][Mm][Dd]|[Ss][Yy][Ss][Tt][Ee][Mm]|[Ee][Ss]([356]|20(1[567]|2[02])|[Nn][Ee][Xx][Tt])|[Nn][Oo][dD][Ee]16|[Nn][Oo][Dd][Ed][Nn][Ee][Xx][Tt]|[Nn][Oo][Nn][Ee])$") & string

			// Specify how TypeScript looks up a file from a given module
			// specifier.
			moduleResolution?: ("Classic" | "Node" | "Node16" | "NodeNext" | =~"^(([Nn]ode)|([Nn]ode16)|([Nn]ode[Nn]ext)|([Cc]lassic))$") & string | *"classic"

			// Set the newline character for emitting files.
			newLine?: ("crlf" | "lf" | =~"^(CRLF|LF|crlf|lf)$") & string

			// Disable emitting file from a compilation.
			noEmit?: bool | *false

			// Disable generating custom helper functions like `__extends` in
			// compiled output.
			noEmitHelpers?: bool | *false

			// Disable emitting files if any type checking errors are
			// reported.
			noEmitOnError?: bool | *false

			// Enable error reporting for expressions and declarations with an
			// implied `any` type..
			noImplicitAny?: bool

			// Enable error reporting when `this` is given the type `any`.
			noImplicitThis?: bool

			// Enable error reporting when a local variables aren't read.
			noUnusedLocals?: bool | *false

			// Raise an error when a function parameter isn't read
			noUnusedParameters?: bool | *false

			// Disable including any library files, including the default
			// lib.d.ts.
			noLib?: bool | *false

			// Disallow `import`s, `require`s or `<reference>`s from expanding
			// the number of files TypeScript should add to a project.
			noResolve?: bool | *false

			// Disable strict checking of generic signatures in function
			// types.
			noStrictGenericChecks?: bool | *false

			// Skip type checking .d.ts files that are included with
			// TypeScript.
			skipDefaultLibCheck?: bool | *false

			// Skip type checking all .d.ts files.
			skipLibCheck?: bool | *false

			// Specify a file that bundles all outputs into one JavaScript
			// file. If `declaration` is true, also designates a file that
			// bundles all .d.ts output.
			outFile?: string

			// Specify an output folder for all emitted files.
			outDir?: string

			// Disable erasing `const enum` declarations in generated code.
			preserveConstEnums?: bool | *false

			// Disable resolving symlinks to their realpath. This correlates
			// to the same flag in node.
			preserveSymlinks?: bool | *false

			// Preserve unused imported values in the JavaScript output that
			// would otherwise be removed
			preserveValueImports?: bool | *false

			// Disable wiping the console in watch mode
			preserveWatchOutput?: bool

			// Enable color and formatting in output to make compiler errors
			// easier to read
			pretty?: bool | *true

			// Disable emitting comments.
			removeComments?: bool | *false

			// Specify the root folder within your source files.
			rootDir?: string

			// Ensure that each file can be safely transpiled without relying
			// on other imports.
			isolatedModules?: bool | *false

			// Create source map files for emitted JavaScript files.
			sourceMap?: bool | *false

			// Specify the root path for debuggers to find the reference
			// source code.
			sourceRoot?: string

			// Disable reporting of excess property errors during the creation
			// of object literals.
			suppressExcessPropertyErrors?: bool | *false

			// Suppress `noImplicitAny` errors when indexing objects that lack
			// index signatures.
			suppressImplicitAnyIndexErrors?: bool | *false

			// Disable emitting declarations that have `@internal` in their
			// JSDoc comments.
			stripInternal?: bool

			// Set the JavaScript language version for emitted JavaScript and
			// include compatible library declarations.
			target?: ("ES3" | "ES5" | "ES6" | "ES2015" | "ES2016" | "ES2017" | "ES2018" | "ES2019" | "ES2020" | "ES2021" | "ES2022" | "ESNext" | =~"^([Ee][Ss]([356]|(20(1[56789]|2[012]))|[Nn][Ee][Xx][Tt]))$") & string | *"ES3"

			// Default catch clause variables as `unknown` instead of `any`.
			useUnknownInCatchVariables?: bool | *false

			// Watch input files.
			watch?: bool

			// Specify the polling strategy to use when the system runs out of
			// or doesn't support native file watchers. Requires TypeScript
			// version 3.8 or later.
			fallbackPolling?: "fixedPollingInterval" | "priorityPollingInterval" | "dynamicPriorityPolling" | "fixedInterval" | "priorityInterval" | "dynamicPriority" | "fixedChunkSize"

			// Specify the strategy for watching directories under systems
			// that lack recursive file-watching functionality. Requires
			// TypeScript version 3.8 or later.
			watchDirectory?: "useFsEvents" | "fixedPollingInterval" | "dynamicPriorityPolling" | "fixedChunkSizePolling" | *"useFsEvents"

			// Specify the strategy for watching individual files. Requires
			// TypeScript version 3.8 or later.
			watchFile?: "fixedPollingInterval" | "priorityPollingInterval" | "dynamicPriorityPolling" | "useFsEvents" | "useFsEventsOnParentDirectory" | "fixedChunkSizePolling" | *"useFsEvents"

			// Enable experimental support for TC39 stage 2 draft decorators.
			experimentalDecorators?: bool

			// Emit design-type metadata for decorated declarations in source
			// files.
			emitDecoratorMetadata?: bool

			// Disable error reporting for unused labels.
			allowUnusedLabels?: bool

			// Enable error reporting for codepaths that do not explicitly
			// return in a function.
			noImplicitReturns?: bool | *false

			// Add `undefined` to a type when accessed using an index.
			noUncheckedIndexedAccess?: bool

			// Enable error reporting for fallthrough cases in switch
			// statements.
			noFallthroughCasesInSwitch?: bool | *false

			// Ensure overriding members in derived classes are marked with an
			// override modifier.
			noImplicitOverride?: bool | *false

			// Disable error reporting for unreachable code.
			allowUnreachableCode?: bool

			// Ensure that casing is correct in imports.
			forceConsistentCasingInFileNames?: bool | *false

			// Emit a v8 CPU profile of the compiler run for debugging.
			generateCpuProfile?: string | *"profile.cpuprofile"

			// Specify the base directory to resolve non-relative module
			// names.
			baseUrl?: string

			// Specify a set of entries that re-map imports to additional
			// lookup locations.
			paths?: {
				[string]: list.UniqueItems() & [...string]
			}

			// Specify a list of language service plugins to include.
			plugins?: [...{
				// Plugin name.
				name?: string
				...
			}]

			// Allow multiple folders to be treated as one when resolving
			// modules.
			rootDirs?: list.UniqueItems() & [...string]

			// Specify multiple folders that act like `./node_modules/@types`.
			typeRoots?: list.UniqueItems() & [...string]

			// Specify type package names to be included without being
			// referenced in a source file.
			types?: list.UniqueItems() & [...string]

			// Enable tracing of the name resolution process. Requires
			// TypeScript version 2.0 or later.
			traceResolution?: bool | *false

			// Allow JavaScript files to be a part of your program. Use the
			// `checkJS` option to get errors from these files.
			allowJs?: bool | *false

			// Disable truncating types in error messages.
			noErrorTruncation?: bool | *false

			// Allow 'import x from y' when a module doesn't have a default
			// export.
			allowSyntheticDefaultImports?: bool

			// Disable adding 'use strict' directives in emitted JavaScript
			// files.
			noImplicitUseStrict?: bool | *false

			// Print the names of emitted files after a compilation.
			listEmittedFiles?: bool | *false

			// Remove the 20mb cap on total source code size for JavaScript
			// files in the TypeScript language server.
			disableSizeLimit?: bool | *false

			// Specify a set of bundled library declaration files that
			// describe the target runtime environment.
			lib?: list.UniqueItems() & [...("ES5" | "ES6" | "ES2015" | "ES2015.Collection" | "ES2015.Core" | "ES2015.Generator" | "ES2015.Iterable" | "ES2015.Promise" | "ES2015.Proxy" | "ES2015.Reflect" | "ES2015.Symbol.WellKnown" | "ES2015.Symbol" | "ES2016" | "ES2016.Array.Include" | "ES2017" | "ES2017.Intl" | "ES2017.Object" | "ES2017.SharedMemory" | "ES2017.String" | "ES2017.TypedArrays" | "ES2018" | "ES2018.AsyncGenerator" | "ES2018.AsyncIterable" | "ES2018.Intl" | "ES2018.Promise" | "ES2018.Regexp" | "ES2019" | "ES2019.Array" | "ES2019.Intl" | "ES2019.Object" | "ES2019.String" | "ES2019.Symbol" | "ES2020" | "ES2020.BigInt" | "ES2020.Promise" | "ES2020.String" | "ES2020.Symbol.WellKnown" | "ESNext" | "ESNext.Array" | "ESNext.AsyncIterable" | "ESNext.BigInt" | "ESNext.Intl" | "ESNext.Promise" | "ESNext.String" | "ESNext.Symbol" | "DOM" | "DOM.Iterable" | "ScriptHost" | "WebWorker" | "WebWorker.ImportScripts" | "Webworker.Iterable" | "ES7" | "ES2021" | "ES2020.SharedMemory" | "ES2020.Intl" | "ES2021.Promise" | "ES2021.String" | "ES2021.WeakRef" | "ESNext.WeakRef" | "es2021.intl" | "ES2022" | "ES2022.Array" | "ES2022.Error" | "ES2022.Intl" | "ES2022.Object" | "ES2022.String" | =~"^[Ee][Ss]5|[Ee][Ss]6|[Ee][Ss]7$" | =~"^[Ee][Ss]2015(\\.([Cc][Oo][Ll][Ll][Ee][Cc][Tt][Ii][Oo][Nn]|[Cc][Oo][Rr][Ee]|[Gg][Ee][Nn][Ee][Rr][Aa][Tt][Oo][Rr]|[Ii][Tt][Ee][Rr][Aa][Bb][Ll][Ee]|[Pp][Rr][Oo][Mm][Ii][Ss][Ee]|[Pp][Rr][Oo][Xx][Yy]|[Rr][Ee][Ff][Ll][Ee][Cc][Tt]|[Ss][Yy][Mm][Bb][Oo][Ll].[Ww][Ee][Ll][Ll][Kk][Nn][Oo][Ww][Nn]|[Ss][Yy][Mm][Bb][Oo][Ll]))?$" | =~"^[Ee][Ss]2016(\\.[Aa][Rr][Rr][Aa][Yy].[Ii][Nn][Cc][Ll][Uu][Dd][Ee])?$" | =~"^[Ee][Ss]2017(\\.([Ii][Nn][Tt][Ll]|[Oo][Bb][Jj][Ee][Cc][Tt]|[Ss][Hh][Aa][Rr][Ee][Dd][Mm][Ee][Mm][Oo][Rr][Yy]|[Ss][Tt][Rr][Ii][Nn][Gg]|[Tt][Yy][Pp][Ee][Dd][Aa][Rr][Rr][Aa][Yy][Ss]))?$" | =~"^[Ee][Ss]2018(\\.([Aa][Ss][Yy][Nn][Cc][Ii][Tt][Ee][Rr][Aa][Bb][Ll][Ee]|[Ii][Nn][Tt][Ll]|[Pp][Rr][Oo][Mm][Ii][Ss][Ee]|[Rr][Ee][Gg][Ee][Xx][Pp]))?$" | =~"^[Ee][Ss]2019(\\.([Aa][Rr][Rr][Aa][Yy]|[Oo][Bb][Jj][Ee][Cc][Tt]|[Ss][Tt][Rr][Ii][Nn][Gg]|[Ss][Yy][Mm][Bb][Oo][Ll]))?$" | =~"^[Ee][Ss]2020(\\.([Bb][Ii][Gg][Ii][Nn][Tt]|[Pp][Rr][Oo][Mm][Ii][Ss][Ee]|[Ss][Tt][Rr][Ii][Nn][Gg]|[Ss][Yy][Mm][Bb][Oo][Ll].[Ww][Ee][Ll][Ll][Kk][Nn][Oo][Ww][Nn]))?$" | =~"^[Ee][Ss]2021(\\.([Ii][Nn][Tt][Ll]|[Pp][Rr][Oo][Mm][Ii][Ss][Ee]|[Ss][Tt][Rr][Ii][Nn][Gg]|[Ww][Ee][Aa][Kk][Rr][Ee][Ff]))?$" | =~"^[Ee][Ss]2022(\\.([Aa][Rr][Rr][Aa][Yy]|[Ee][Rr][Rr][Oo][Rr]|[Ii][Nn][Tt][Ll]|[Oo][Bb][Jj][Ee][Cc][Tt]|[Ss][Tt][Rr][Ii][Nn][Gg]))?$" | =~"^[Ee][Ss][Nn][Ee][Xx][Tt](\\.([Aa][Rr][Rr][Aa][Yy]|[Aa][Ss][Yy][Nn][Cc][Ii][Tt][Ee][Rr][Aa][Bb][Ll][Ee]|[Bb][Ii][Gg][Ii][Nn][Tt]|[Ii][Nn][Tt][Ll]|[Pp][Rr][Oo][Mm][Ii][Ss][Ee]|[Ss][Tt][Rr][Ii][Nn][Gg]|[Ss][Yy][Mm][Bb][Oo][Ll]|[Ww][Ee][Aa][Kk][Rr][Ee][Ff]))?$" | =~"^[Dd][Oo][Mm](\\.[Ii][Tt][Ee][Rr][Aa][Bb][Ll][Ee])?$" | =~"^[Ss][Cc][Rr][Ii][Pp][Tt][Hh][Oo][Ss][Tt]$" | =~"^[Ww][Ee][Bb][Ww][Oo][Rr][Kk][Ee][Rr](\\.[Ii][Mm][Pp][Oo][Rr][Tt][Ss][Cc][Rr][Ii][Pp][Tt][Ss])?$") & string]

			// Specify how TypeScript determine a file as module.
			moduleDetection?: "auto" | "legacy" | "force"

			// When type checking, take into account `null` and `undefined`.
			strictNullChecks?: bool | *false

			// Specify the maximum folder depth used for checking JavaScript
			// files from `node_modules`. Only applicable with `allowJs`.
			maxNodeModuleJsDepth?: number | *0

			// Allow importing helper functions from tslib once per project,
			// instead of including them per-file.
			importHelpers?: bool | *false

			// Specify emit/checking behavior for imports that are only used
			// for types.
			importsNotUsedAsValues?: "remove" | "preserve" | "error" | *"remove"

			// Ensure 'use strict' is always emitted.
			alwaysStrict?: bool

			// Enable all strict type checking options.
			strict?: bool | *false

			// Check that the arguments for `bind`, `call`, and `apply`
			// methods match the original function.
			strictBindCallApply?: bool | *false

			// Emit more compliant, but verbose and less performant JavaScript
			// for iteration.
			downlevelIteration?: bool | *false

			// Enable error reporting in type-checked JavaScript files.
			checkJs?: bool | *false

			// When assigning functions, check to ensure parameters and the
			// return values are subtype-compatible.
			strictFunctionTypes?: bool | *false

			// Check for class properties that are declared but not set in the
			// constructor.
			strictPropertyInitialization?: bool | *false

			// Emit additional JavaScript to ease support for importing
			// CommonJS modules. This enables `allowSyntheticDefaultImports`
			// for type compatibility.
			esModuleInterop?: bool | *false

			// Allow accessing UMD globals from modules.
			allowUmdGlobalAccess?: bool | *false

			// Make keyof only return strings instead of string, numbers or
			// symbols. Legacy option.
			keyofStringsOnly?: bool | *false

			// Emit ECMAScript-standard-compliant class fields.
			useDefineForClassFields?: bool | *false

			// Create sourcemaps for d.ts files.
			declarationMap?: bool | *false

			// Enable importing .json files
			resolveJsonModule?: bool | *false

			// Have recompiles in '--incremental' and '--watch' assume that
			// changes within a file will only affect files directly
			// depending on it. Requires TypeScript version 3.8 or later.
			assumeChangesOnlyAffectDirectDependencies?: bool

			// Output more detailed compiler performance information after
			// building.
			extendedDiagnostics?: bool | *false

			// Print names of files that are part of the compilation and then
			// stop processing.
			listFilesOnly?: bool

			// Disable preferring source files instead of declaration files
			// when referencing composite projects
			disableSourceOfProjectReferenceRedirect?: bool

			// Opt a project out of multi-project reference checking when
			// editing.
			disableSolutionSearching?: bool
			...
		}
		...
	}

	#typeAcquisitionDefinition: null | bool | number | string | [...] | {
		// Auto type (.d.ts) acquisition options for this project.
		// Requires TypeScript version 2.1 or later.
		typeAcquisition?: {
			// Enable auto type acquisition
			enable?: bool | *false

			// Specifies a list of type declarations to be included in auto
			// type acquisition. Ex. ["jquery", "lodash"]
			include?: list.UniqueItems() & [...string]

			// Specifies a list of type declarations to be excluded from auto
			// type acquisition. Ex. ["jquery", "lodash"]
			exclude?: list.UniqueItems() & [...string]
			...
		}
		...
	}

	#referencesDefinition: null | bool | number | string | [...] | {
		// Referenced projects. Requires TypeScript version 3.0 or later.
		references?: list.UniqueItems() & [...{
			// Path to referenced tsconfig or to folder containing tsconfig.
			path?: string
			...
		}]
		...
	}

	#tsNodeModuleTypes: {
		...
	}

	#tsNodeDefinition: null | bool | number | string | [...] | {
		// ts-node options. See also:
		// https://typestrong.org/ts-node/docs/configuration
		//
		// ts-node offers TypeScript execution and REPL for node.js, with
		// source map support.
		"ts-node"?: {
			// Specify a custom TypeScript compiler.
			compiler?: string | *"typescript"

			// Use TypeScript's compiler host API instead of the language
			// service API.
			compilerHost?: bool | *false

			// JSON object to merge with TypeScript `compilerOptions`.
			compilerOptions?: #compilerOptionsDefinition.compilerOptions & {
				...
			}

			// Emit output files into `.ts-node` directory.
			emit?: bool | *false

			// Enable native ESM support.
			//
			// For details, see
			// https://typestrong.org/ts-node/docs/imports#native-ecmascript-modules
			esm?: bool

			// Allows the usage of top level await in REPL.
			//
			// Uses node's implementation which accomplishes this with an AST
			// syntax transformation.
			//
			// Enabled by default when tsconfig target is es2018 or above. Set
			// to false to disable.
			//
			// **Note**: setting to `true` when tsconfig target is too low
			// will throw an Error. Leave as `undefined`
			// to get default, automatic behavior.
			experimentalReplAwait?: bool

			// Enable experimental features that re-map imports and require
			// calls to support:
			// `baseUrl`, `paths`, `rootDirs`, `.js` to `.ts` file extension
			// mappings,
			// `outDir` to `rootDir` mappings for composite projects and
			// monorepos.
			//
			// For details, see
			// https://github.com/TypeStrong/ts-node/issues/1514
			experimentalResolver?: bool

			// Like node's `--experimental-specifier-resolution`, , but can
			// also be set in your `tsconfig.json` for convenience.
			//
			// For details, see
			// https://nodejs.org/dist/latest-v18.x/docs/api/esm.html#customizing-esm-specifier-resolution-algorithm
			experimentalSpecifierResolution?: "explicit" | "node"

			// Load "files" and "include" from `tsconfig.json` on startup.
			//
			// Default is to override `tsconfig.json` "files" and "include" to
			// only include the entrypoint script.
			files?: bool | *false

			// Paths which should not be compiled.
			//
			// Each string in the array is converted to a regular expression
			// via `new RegExp()` and tested against source paths prior to
			// compilation.
			//
			// Source paths are normalized to posix-style separators, relative
			// to the directory containing `tsconfig.json` or to cwd if no
			// `tsconfig.json` is loaded.
			//
			// Default is to ignore all node_modules subdirectories.
			ignore?: [...string] | *["(?:^|/)node_modules/"]

			// Ignore TypeScript warnings by diagnostic code.
			ignoreDiagnostics?: [...number | string]

			// Logs TypeScript errors to stderr instead of throwing
			// exceptions.
			logError?: bool | *false

			// Override certain paths to be compiled and executed as CommonJS
			// or ECMAScript modules.
			// When overridden, the tsconfig "module" and package.json "type"
			// fields are overridden, and
			// the file extension is ignored.
			// This is useful if you cannot use .mts, .cts, .mjs, or .cjs file
			// extensions;
			// it achieves the same effect.
			//
			// Each key is a glob pattern following the same rules as
			// tsconfig's "include" array.
			// When multiple patterns match the same file, the last pattern
			// takes precedence.
			//
			// `cjs` overrides matches files to compile and execute as
			// CommonJS.
			// `esm` overrides matches files to compile and execute as native
			// ECMAScript modules.
			// `package` overrides either of the above to default behavior,
			// which obeys package.json "type" and
			// tsconfig.json "module" options.
			moduleTypes?: #tsNodeModuleTypes

			// Re-order file extensions so that TypeScript imports are
			// preferred.
			//
			// For example, when both `index.js` and `index.ts` exist,
			// enabling this option causes `require('./index')` to resolve to
			// `index.ts` instead of `index.js`
			preferTsExts?: bool | *false

			// Use pretty diagnostic formatter.
			pretty?: bool | *false

			// Modules to require, like node's `--require` flag.
			//
			// If specified in `tsconfig.json`, the modules will be resolved
			// relative to the `tsconfig.json` file.
			//
			// If specified programmatically, each input string should be
			// pre-resolved to an absolute path for
			// best results.
			require?: [...string]

			// Scope compiler to files within `scopeDir`.
			scope?:    bool | *false
			scopeDir?: string | *"First of: `tsconfig.json` \"rootDir\" if specified, directory containing `tsconfig.json`, or cwd if no `tsconfig.json` is loaded."

			// Skip ignore check, so that compilation will be attempted for
			// all files with matching extensions.
			skipIgnore?: bool | *false

			// Transpile with swc instead of the TypeScript compiler, and skip
			// typechecking.
			//
			// Equivalent to setting both `transpileOnly: true` and
			// `transpiler: 'ts-node/transpilers/swc'`
			//
			// For complete instructions:
			// https://typestrong.org/ts-node/docs/transpilers
			swc?: bool

			// Use TypeScript's faster `transpileModule`.
			transpileOnly?: bool | *false

			// Specify a custom transpiler for use with transpileOnly
			transpiler?: (list.MaxItems(2) & [string, {
				...
			}] & [_, _, ...] | string) & (string | [...])

			// **DEPRECATED** Specify type-check is enabled (e.g.
			// `transpileOnly == false`).
			typeCheck?: bool | *true
			...
		}
		...
	}
}
