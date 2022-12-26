package datapack

_#Schema: {
	// Minecraft Data Pack Metadata
	//
	// Configuration file defining the metadata of a data pack for
	// Minecraft.
	@jsonschema(schema="http://json-schema.org/draft-07/schema#")

	// Pack
	pack?: {
		// Pack Format
		pack_format?: number

		// Description
		description?: string
		...
	}
	...
}
