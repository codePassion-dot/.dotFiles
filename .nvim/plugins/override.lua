-- overriding default plugin configs!

local M = {}

M.nvimtree = {
	view = {
		side = "left",
		width = 50,
		hide_root_folder = true,
	},
	renderer = {
		highlight_git = true,
		icons = {
			show = {
				git = true,
			},
		},
	},
}
M.mason = {
	ensure_installed = {
		-- lua stuff
		"lua-language-server",
		"stylua",

		-- web dev
		"css-lsp",
		"html-lsp",
		"typescript-language-server",
		"deno",
		"emmet-ls",
		"json-lsp",
		"tailwindcss-language-server",

		-- shell
		"shfmt",
		"shellcheck",
	},
}

M.telescope = {
	extensions = {
		-- fdfind is needed
		media_files = {
			filetypes = { "png", "webp", "jpg", "jpeg", "svg" },
		},
	},
}

return M
