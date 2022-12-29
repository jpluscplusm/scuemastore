package unist_tests

import "strings"

integration: {
	positive: strings.Join(_positive, "\n")
	_positive: [
		for vend in [
			"root-full.json",
			"root-full.with-data.json",
			"root-full.with-position.json",
			"root-full.with-value.json",
			"void-root.json",
			"void-root.with-additional-prop.json",
			"void-root.with-children.json",
			"void-root.with-data.json",
			"void-root.with-position.json",
			"void-root.with-value.json",
		] {
			".build/upstream/src/test/unist/" + vend
		},
	]
	negative: strings.Join(_negative, "\n")
	_negative: [
		for vend in [
			"void-root.missing-type.json",
			"void-root.with-data.non-object.json",
			"void-root.with-position.forbidden-point-prop.json",
			"void-root.with-position.forbidden-prop.json",
			"void-root.with-position.missing-end-column.json",
			"void-root.with-position.missing-end.json",
			"void-root.with-position.missing-end-line.json",
			"void-root.with-position.missing-start-column.json",
			"void-root.with-position.missing-start.json",
			"void-root.with-position.missing-start-line.json",
		] {
			".build/upstream/src/negative_test/unist/" + vend
		},
	]
}
