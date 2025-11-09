return {
  {
    "mistricky/codesnap.nvim",
    build = "make build_generator",
    keys = {
      { "<leader>cs", "<Esc><cmd>CodeSnap<cr>", mode = "x", desc = "code screenshot" },
    },
    opts = {
      save_path = "~/Pictures",
      watermark = "",
    },
  },
}
