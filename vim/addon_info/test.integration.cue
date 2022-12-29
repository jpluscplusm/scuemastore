package addon_info_tests

import "strings"

integration: {
	positive: strings.Join(_positive, "\n")
	_positive: [
		".build/upstream/src/test/vim-addon-info/basic-example.json",
		".build/upstream/src/test/vim-addon-info/with-dependencies.json",
	]
	negative: strings.Join(_negative, "\n")
	_negative: [
	]
}
