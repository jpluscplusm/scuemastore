package datapack_tests

import "strings"

integration: {
	positive: strings.Join(_positive, "\n")
	_positive: [
		".build/upstream/src/test/minecraft-pack-mcmeta/default.json",
	]
	negative: strings.Join(_negative, "\n")
	_negative: [
	]
}
