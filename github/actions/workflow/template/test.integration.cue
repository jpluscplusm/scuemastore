package template_tests

import "strings"

integration: {
	positive: strings.Join(_positive, "\n")
	_positive: [
		for vend in [
			"blank.json",
			"c-cpp.json",
		] {
			".build/upstream/src/test/github-workflow-template-properties/" + vend
		},
		for local in [
		] {
			"github/actions/workflow/.fixtures/valid/" + local
		},
	]
	negative: strings.Join(_negative, "\n")
	_negative: [
		for vend in [
		] {
			".build/upstream/src/negative_test/github-workflow-template-properties/" + vend
		},
		for local in [
			"unknown-categories.json",
			"unknown-category.json",
		] {
			"github/actions/workflow/template/.fixtures/invalid/" + local
		},
	]
}
