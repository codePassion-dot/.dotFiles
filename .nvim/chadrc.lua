-- Just an example, supposed to be placed in /lua/custom/

local M = {}

local override = require("custom.plugins.override")

-- make sure you maintain the structure of `core/default_config.lua` here,
-- example of changing theme:

M.ui = {
	theme = "gatekeeper",
}

M.mappings = require("custom.mappings")

M.plugins = {
	user = require("custom.plugins"),
	override = {
		["kyazdani42/nvim-tree.lua"] = override.nvimtree,
		["nvim-telescope/telescope.nvim"] = override.telescope,
		["williamboman/mason.nvim"] = override.mason,
	},
}

return M
