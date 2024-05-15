local util = require("lspconfig.util")

local function get_typescript_server_path(root_dir)
  local project_root = util.find_node_modules_ancestor(root_dir)
  return project_root and (util.path.join(project_root, "node_modules", "typescript", "lib")) or ""
end
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tailwindcss = {
          settings = {
            tailwindCSS = {
              experimental = {
                classRegex = {
                  { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                  { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                },
              },
            },
          },
        },
        mdx_analyzer = {
          filetypes = {
            "mdx",
            "markdown.mdx",
          },
          init_options = {
            typescript = {},
          },
          on_new_config = function(new_config, new_root_dir)
            if vim.tbl_get(new_config.init_options, "typescript") and not new_config.init_options.typescript.tsdk then
              -- LATER: Support custom typescript lib
              --
              -- local tsdk = require("util.typescript").get_tsdk_from_config() or get_typescript_server_path(new_root_dir)
              new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
            end
          end,
        },
      },
    },
  },
}
