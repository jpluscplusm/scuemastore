package addon_info

_#Schema: {
	_schema
	_schema: {
		// JSON schema for vim plugin addon-info.json metadata files
		@jsonschema(schema="http://json-schema.org/draft-07/schema#")
		@jsonschema(id="https://json.schemastore.org/vim-addon-info")

		// The name of the plugin. Used by plugin managers and some
		// introspection tools. Generally corresponds to the name of the
		// repository but without "vim" prefix/suffix.
		name?: string

		// Dotted version number of the plugin, generally in semantic
		// versioning scheme.
		version?: string | *"0.0.1"

		// Short description of the plugin and what it does (a sentence or
		// two)
		description?: string

		// Primary homepage of the plugin.
		homepage?: string

		// Name of the person or organization that created the plugin
		author?: string

		// Name of the person who maintains the plugin
		maintainer?: string
		repository?: #selfRepository

		// Plugins that are strictly required for the plugin to work,
		// where keys are plugin names and values may describe where
		// plugins can be fetched from.
		dependencies?: {
			[string]: #otherRepository
		}

		#url: string

		#repoType: "hg" | "git" | "svn" | "bzr"

		#selfRepository: {
			type?: #repoType
			url?:  #url

			// For a deprecated plugin, a deprecation message to be shown to
			// any user who installs the plugin.
			deprecated?: string
			...
		}

		#otherRepository: ({
			...
		} | {
			type?: "" | "archive"
			url?:  #url

			// Script ID number of the target plugin on www.vim.org, if any.
			vim_script_nr?: number
			"script-type"?: "color scheme" | "ftplugin" | "game" | "indent" | "syntax" | "utility" | "patch"
			...
		} | {
			type: #repoType
			url:  #url
			...
		}) & {
			// Primary homepage of the plugin.
			homepage?:     string
			"addon-info"?: _schema_1
			...
		}
		...
	}

	let _schema_1 = _schema
}
