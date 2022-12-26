package makefile

import (
	"strings"
)

_files: {
}

dynamic: {
	strings.Join(_array, "\n")
	_array: [ for k, v in _files {
		let package = strings.Split(k, "/")[strings.Count(k, "/")]
		"""
		ALL += \(k)/schema.cue
		\(k)/schema.cue: PACKAGE=\(package)
		\(k)/schema.cue: \(v)
		ALL += \(k)/embed.cue
		\(k)/embed.cue: PACKAGE=\(package)
		#\(k)/embed.cue: \(v)
		"""
	}]
}
