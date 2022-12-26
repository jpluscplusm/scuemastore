package prettierrc

_#Schema: {
	// Schema for .prettierrc
	@jsonschema(schema="http://json-schema.org/draft-04/schema#")
	#optionsDefinition & #overridesDefinition

	#optionsDefinition: null | bool | number | string | [...] | {
		// Include parentheses around a sole arrow function parameter.
		arrowParens?: "avoid" | "always" | *"avoid"

		// Print spaces between brackets in object literals.
		bracketSpacing?: bool | *true

		// Insert @format pragma into file's first docblock comment.
		insertPragma?: bool | *false

		// Put the > of a multi-line JSX element at the end of the last
		// line instead of being alone on the next line.
		jsxBracketSameLine?: bool | *false

		// Specify which parser to use.
		parser?: "babylon" | "flow" | "typescript" | "postcss" | "json" | "graphql" | "markdown" | *"babylon"

		// Specify the line length that the printer will wrap on.
		printWidth?: int | *80

		// How to wrap prose.
		proseWrap?: "always" | "never" | "preserve" | *"preserve"

		// Require either '@prettier' or '@format' to be present in the
		// file's first docblock comment in order for it to be formatted.
		requirePragma?: bool | *false

		// Print semicolons at the ends of statements.
		semi?: bool | *true

		// Use single quotes instead of double quotes.
		singleQuote?: bool | *false

		// Specify the number of spaces per indentation-level.
		tabWidth?: int | *2

		// Print trailing commas wherever possible.
		trailingComma?: "none" | "all" | "es5" | *"none"

		// Indent lines with tabs instead of spaces.
		useTabs?: bool | *false
		...
	}

	#overridesDefinition: null | bool | number | string | [...] | {
		// Provide a list of patterns to override prettier configuration.
		overrides?: [...{
			// Include these files in this override.
			files: string | [...string]

			// Exclude these files from this override.
			excludeFiles?: string | [...string]

			// The options to apply for this override.
			options?: #optionsDefinition
		}]
		...
	}
}
