return {
  {
    "folke/which-key.nvim",
    opts = {
      plugins = { spelling = true },
      defaults = {
        mode = { "n" },
        ["<leader>gd"] = { name = "+Diffview" },
        ["<leader>gdf"] = { name = "+DiffviewFileHistory" },
      },
    },
  },
}
