return {
	["jose-elias-alvarez/null-ls.nvim"] = {
		after = "nvim-lspconfig",
		config = function()
			require("custom.plugins.null-ls").setup()
		end,
	},
	["windwp/nvim-ts-autotag"] = {
		ft = { "html", "javascriptreact", "typescriptreact" },
		after = "nvim-treesitter",
		config = function()
			local present, autotag = pcall(require, "nvim-ts-autotag")
			if present then
				autotag.setup()
			end
		end,
	},
	["neovim/nvim-lspconfig"] = {
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.plugins.lspconfig")
		end,
	},
	["folke/trouble.nvim"] = {
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({})
		end,
	},
	["github/copilot.vim"] = {},
	["jose-elias-alvarez/nvim-lsp-ts-utils"] = {},
}

-- load it after nvim-lspconfig cuz we lazy loaded lspconfig
