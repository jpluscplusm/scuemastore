package makefile

import (
	"strings"
)

_files: [string]: #SchemaStoreJSON
_files: {
	"github-workflow.json": {
		path: "github/actions/workflow"
		tests: integration: true
		tests: unit:        true
	}
	"github-workflow-template-properties.json": {
		path: "github/actions/workflow/template"
		tests: integration: true
	}
	"minecraft-pack-mcmeta.json": {
		path: "microsoft/minecraft/datapack"
		tests: integration: true
	}
	"lsdlschema-0.7.json": {
		path: "microsoft/power_bi/lsdl_0_7"
	}
	"lsdlschema-1.0.json": {
		path: "microsoft/power_bi/lsdl_1_0"
	}
	"lsdlschema-1.2.json": {
		path: "microsoft/power_bi/lsdl_1_2"
	}
	"lsdlschema-2.0.json": {
		path: "microsoft/power_bi/lsdl_2_0"
	}
	"lsdlschema-3.0.json": {
		path: "microsoft/power_bi/lsdl_3_0"
	}
	"lsdlschema-3.1.json": {
		path: "microsoft/power_bi/lsdl_3_1"
	}
	"lsdlschema-3.2.json": {
		path: "microsoft/power_bi/lsdl_3_2"
	}
	"lsdlschema-3.3.json": {
		path: "microsoft/power_bi/lsdl_3_3"
	}
	"lsdlschema-3.4.json": {
		path: "microsoft/power_bi/lsdl_3_4"
	}
	"tsconfig.json": {
		path: "microsoft/typescript/tsconfig"
		tests: integration: true
	}
	"prettierrc.json": {
		path: "prettier/prettierrc"
		tests: integration: true
	}
	"unist.json": {
		path: "unifiedjs/syntax_tree/unist"
		tests: integration: true
	}
	"vim-addon-info.json": {
		path: "vim/addon_info"
		tests: integration: true
	}
}

#SchemaStoreJSON: {
	path:    string & !=""
	package: *strings.Split(path, "/")[strings.Count(path, "/")] | string
	tests: {
		unit:        *false | bool
		integration: *false | bool
	}
}

Makefile: {

	#Makefile: {
		_lines: [...string]
		"""
			# This Makefile was automatically generated from a CUE definition.
			# Any manual changes to it may be overwritten.
			
			""" +
		strings.Join(_lines, "\n")
	}

	SCHEMASTORE_CUE: #Makefile & {_
		_lines: [ for k, v in _files {
			"""
			SCHEMASTORE_CUE += \(v.path)/schemastore.cue
			SCHEMASTORE_CUE += \(v.path)/schemastore-embed.cue
			"""
		}]
	}

	generated_files: #Makefile & {_
		_lines: [ for k, v in _files {
			"""
			\(v.path)/schemastore-embed.cue: PACKAGE_NAME=\(v.package)
			\(v.path)/schemastore.cue: PACKAGE_NAME=\(v.package)
			\(v.path)/schemastore.cue: \(k)
			"""
		}]
	}

	TESTS: #Makefile & {_
		_lines: [
			for k, v in _files if v.tests.integration {
				let test_path = "\(v.path)/test.integration.cue.run"
				"""
			\(test_path): PACKAGE_PATH=\(v.path)
			\(test_path): TEST_PACKAGE_NAME=\(v.package)_tests
			INTEGRATION_TESTS += \(test_path)
			"""
			}] + [
			for k, v in _files if v.tests.unit {
				let test_path = "\(v.path)/test.unit.cue.run"
				"""
			\(test_path): PACKAGE_PATH=\(v.path)
			\(test_path): TEST_PACKAGE_NAME=\(v.package)_tests
			UNIT_TESTS += \(test_path)
			"""
			}]
	}

}
