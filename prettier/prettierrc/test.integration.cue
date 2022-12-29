package prettierrc_tests

import "strings"

integration: {
	positive: strings.Join(_positive, "\n")
	_positive: [
		".build/upstream/src/test/prettierrc/prettierrc.json",
		".build/upstream/src/test/prettierrc/.prettierrc.yml",
	]
	negative: strings.Join(_negative, "\n")
	_negative: [
		".build/upstream/src/negative_test/prettierrc/.prettierrc.yaml",
	]
}
