local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local lspconfig = require("lspconfig")
local servers = { "html", "cssls", "bashls", "emmet_ls", "tsserver", "tailwindcss" }

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = function(client, bufnr)
			on_attach(client, bufnr)
			if lsp == "tsserver" then
				local ts_utils = require("nvim-lsp-ts-utils")
				ts_utils.setup({
					filter_out_diagnostics_by_severity = { "hint" },
				})
				ts_utils.setup_client(client)
			end
		end,
		capabilities = capabilities,
	})
end
