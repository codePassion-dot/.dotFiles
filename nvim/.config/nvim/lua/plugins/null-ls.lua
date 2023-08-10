return {
  "jose-elias-alvarez/null-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "mason.nvim" },
  opts = function()
    local nls = require("null-ls")
    return {
      root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
      sources = {
        nls.builtins.formatting.prettier,
        nls.builtins.formatting.stylua,
        nls.builtins.formatting.phpcsfixer,
        nls.builtins.formatting.black,
        nls.builtins.diagnostics.stylelint.with({
          filetypes = { "scss", "less", "css", "sass", "typescriptreact", "javascriptreact" },
        }),
      },
    }
  end,
}
