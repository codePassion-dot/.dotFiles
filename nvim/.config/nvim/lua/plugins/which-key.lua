return {
  {
    "folke/which-key.nvim",
    opts = {
      plugins = { spelling = true },
      spec = {
        { "<leader>gd", group = "Diffview" },
        { "<leader>gdf", group = "DiffviewFileHistory" },
      },
    },
  },
}
