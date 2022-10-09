local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local lspconfig = require("lspconfig")
local servers = { "html", "volar", "cssls", "bashls", "emmet_ls", "tsserver", "tailwindcss", "vuels", "hls" }

for _, lsp in ipairs(servers) do
	if lsp == "tsserver" then
		lspconfig.tsserver.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				diagnostics = {
					ignoredCodes = {
						-- https://github.com/microsoft/TypeScript/blob/main/src/compiler/diagnosticMessages.json
						7016, -- ts7016: The file is not a module.
						6133, -- ts6133: '{0}' is declared but its value is never read.
					},
				},
			},
		})
	elseif lsp == "volar" then
		lspconfig.volar.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			filetypes = { "vue" },
		})
	else
		lspconfig[lsp].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
	end
end
