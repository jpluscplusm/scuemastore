package makefile

import (
	"strings"
)

_files: {
	"github/actions/workflow":          "github-workflow.json"
	"github/actions/workflow/template": "github-workflow-template-properties.json"
	"microsoft/minecraft/datapack":     "minecraft-pack-mcmeta.json"
	"microsoft/power_bi/lsdl_0_7":      "lsdlschema-0.7.json"
	"microsoft/power_bi/lsdl_1_0":      "lsdlschema-1.0.json"
	"microsoft/power_bi/lsdl_1_2":      "lsdlschema-1.2.json"
	"microsoft/power_bi/lsdl_2_0":      "lsdlschema-2.0.json"
	"microsoft/power_bi/lsdl_3_0":      "lsdlschema-3.0.json"
	"microsoft/power_bi/lsdl_3_1":      "lsdlschema-3.1.json"
	"microsoft/power_bi/lsdl_3_2":      "lsdlschema-3.2.json"
	"microsoft/power_bi/lsdl_3_3":      "lsdlschema-3.3.json"
	"microsoft/power_bi/lsdl_3_4":      "lsdlschema-3.4.json"
	"microsoft/typescript/tsconfig":    "tsconfig.json"
	"prettier/prettierrc":              "prettierrc-1.8.2.json"
	"unifiedjs/syntax_tree/unist":      "unist.json"
	"vim/addon_info":                   "vim-addon-info.json"
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
