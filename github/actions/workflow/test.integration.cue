package workflow_tests

import "strings"

integration: {
	positive: strings.Join(_positive, "\n")
	_positive: [
		for vend in [
			"918.yaml",
			"919.yaml",
			"call-reusable-workflow-inherit-secrets.yaml",
			"call-reusable-workflow-local-file.yaml",
			"call-reusable-workflow.yaml",
			"concurrency.yaml",
			"conditions.yaml",
			"containers.yaml",
			"continue-on-error.yaml",
			//"defaults.yaml",
			"env-from-json.yaml",
			"environments.yaml",
			"env-with-simple-expression.yaml",
			"event-trigger.yaml",
			"issue_2463_file_1.yaml",
			//"issue_2463_file_2.yaml",
			//"matrix_from_json.yaml",
			"matrix_include.yaml",
			"npm-publish.yaml",
			//"on-event_name-null.yaml",
			//"permissions-none.yaml",
			//"permissions-object.yaml",
			//"permissions-string.yaml",
			"reusable-workflow.yaml",
			//"runs-on-interpolated.yaml",
			"runs-on.yaml",
			//"with-from-json.yaml",
			"workflow_call_input_issue_2501.yaml",
			"workflow_dispatch-inputs.yaml",
		] {
			".build/upstream/src/test/github-workflow/" + vend
		},
		for local in [
			"artifact-tests.yml",
			"audit.yml",
			"cache-tests.yml",
			"releases.yml",
			"unit-tests.yml",
			"update-github.yaml",
		] {
			"github/actions/workflow/.fixtures/valid/" + local
		},
	]
	negative: strings.Join(_negative, "\n")
	_negative: [
		for vend in [
			//"all-steps-must-contain-run-or-uses.yaml",
			//"empty_json_must_always_fail.yaml",
			"env-must-be-object-or-has-from-json.yaml",
			"permissions-event-has-wrong-level.yaml",
			"permissions-event-has-wrong-property-keys.yaml",
			"permissions-must-be-object-or-string.yaml",
			"permissions-string-is-not-from-enum.yaml",
			//"reusable-workflow-input-must-declare-type.yaml",
			"reusable-workflow-uses-has-wrong-filetype.yaml",
			"reusable-workflow-uses-has-wrong-pattern.yaml",
			"runs-on.yaml",
			"steps-must-contain-run-or-uses.yaml",
			"with-must-be-object-or-has-from-json-copy.yaml",
			//"workflow_dispatch-inputs-bool-default-.yaml",
			//"workflow_dispatch-inputs-choice-without-options.yaml",
			//"workflow_dispatch-inputs-string-default-bool.yaml",
		] {
			".build/upstream/src/negative_test/github-workflow/" + vend
		},
	]
}
