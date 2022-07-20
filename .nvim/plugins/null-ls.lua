local present, null_ls = pcall(require, "null-ls")

if not present then
   return
end

local b = null_ls.builtins

local sources = {

   -- webdev stuff
   b.formatting.prettierd.with {
      filetypes = { "html", "markdown", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
   },
   b.diagnostics.eslint_d.with {
      filetypes = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
   },
   b.code_actions.eslint_d.with {
      filetypes = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
   },
   b.formatting.rustywind.with {
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
   },

   -- Lua
   b.formatting.stylua,
   b.diagnostics.luacheck.with { extra_args = { "--global vim" } },

   -- Shell
   b.formatting.shfmt,
   b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },
}

local M = {}
M.setup = function()
   null_ls.setup {
      debug = true,
      sources = sources,

      -- format on save
      on_attach = function(client)
         if client.resolved_capabilities.document_formatting then
            vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()"
         end
      end,
   }
end

return M
