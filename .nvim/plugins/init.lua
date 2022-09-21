return {

	["jose-elias-alvarez/null-ls.nvim"] = {
		after = "nvim-lspconfig",
		config = function()
			require("custom.plugins.null-ls").setup()
		end,
	},
	["ThePrimeagen/vim-be-good"] = {
		cmd = "VimBeGood",
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
	["folke/trouble.nvim"] = {
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({})
		end,
	},
	["folke/which-key.nvim"] = {
		disable = false,
	},
	["williamboman/mason.nvim"] = {
		ensure_installed = {
			-- lua stuff
			"lua-language-server",
			"stylua",

			-- web dev
			"css-lsp",
			"prettierd",
			"html-lsp",
			"typescript-language-server",
			"deno",
			"emmet-ls",
			"json-lsp",
			"vue-language-server",

			-- shell
			"shfmt",
			"shellcheck",
		},
	},
	["github/copilot.vim"] = {},
	["neovim/nvim-lspconfig"] = {
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.plugins.lspconfig")
		end,
	},
}

-- load it after nvim-lspconfig cuz we lazy loaded lspconfig
