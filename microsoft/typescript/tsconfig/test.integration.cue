package tsconfig_tests

import "strings"

integration: {
	positive: strings.Join(_positive, "\n")
	_positive: [
		for vend in [
			"hejlsberg.json",
			"tsconfig-extends-multiple.json",
			"tsconfig-extends-single.json",
			"tsconfig.json",
			"tsconfig-newline.json",
			"tsconfig-test2.json",
			"tsconfig-test.json",
		] {
			".build/upstream/src/test/tsconfig/" + vend
		},
		for local in [
		] {
			"microsoft/typescript/tsconfig/.fixtures/valid/" + local
		},
	]
	negative: strings.Join(_negative, "\n")
	_negative: [
		for vend in [
		] {
			".build/upstream/src/negative_test/github-workflow/" + vend
		},
	]
}
