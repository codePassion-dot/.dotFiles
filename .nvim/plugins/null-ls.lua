local present, null_ls = pcall(require, "null-ls")

if not present then
	return
end

local b = null_ls.builtins

local sources = {

	-- webdev stuff
	b.formatting.prettier.with({
		filetypes = {
			"html",
			"markdown",
			"css",
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"vue",
		},
	}),

	b.formatting.brittany.with({
		filetypes = { "haskell" },
	}),

	b.diagnostics.eslint.with({
		filetypes = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
	}),

	b.code_actions.eslint.with({
		filetypes = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
	}),

	-- Lua
	b.formatting.stylua,
	b.diagnostics.luacheck.with({ extra_args = { "--global vim" } }),

	-- Shell
	b.formatting.shfmt,
	b.diagnostics.shellcheck.with({ diagnostics_format = "#{m} [#{c}]" }),
}

local M = {}
M.setup = function()
	null_ls.setup({
		debug = true,
		sources = sources,

		-- format on save
		on_attach = function(client)
			if client.server_capabilities then
				vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
			end
		end,
	})
end

return M
