package workflow_tests

import (
	sut "jonathanmatthews.com/x/schemastore.org/github/actions/workflow"
)

unit: {
	positive: [string]: sut
	positive: {
		schema_has_basic_expected_params: {
			on: "push"
		}
	}

	negative: [string]: {
		test: {}
		result: true & ( {sut & test} == _|_ )
	}
	negative: {
		disallows_unknown_params: test: an_unknown_param: true
		disallows_incorrect_values: test: on:             "wrong value"
	}
}
