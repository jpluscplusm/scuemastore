package unist

_#Schema: {
	_schema
	_schema: {
		// JSON schema for unist syntax trees
		//
		// Syntactic units in unist syntax trees are called nodes, and
		// implement the Node interface.
		@jsonschema(schema="http://json-schema.org/draft-07/schema#")

		// The type field is a non-empty string representing the variant
		// of a node. This field can be used to determine the type a node
		// implements.
		type:      string
		position?: #Position

		// The children field is a list representing the children of a
		// node.
		children?: [..._schema_1]

		// The data field represents information from the ecosystem. The
		// value of the data field implements the Data interface.
		data?: {
			...
		}

		// The value field can contain any value.
		value?: _

		#Point: {
			// The column field (1-indexed integer) represents a column in a
			// source file.
			column: int & >=1

			// The line field (1-indexed integer) represents a line in a
			// source file.
			line: int & >=1

			// The offset field (0-indexed integer) represents a character in
			// a source file.
			offset?: int & >=0
		}

		#Position: {
			// The end field of Position represents the place of the first
			// character after the parsed source region, whether it exists or
			// not.
			end: #Point

			// The start field of Position represents the place of the first
			// character of the parsed source region.
			start: #Point
		}
		...
	}

	let _schema_1 = _schema
}
