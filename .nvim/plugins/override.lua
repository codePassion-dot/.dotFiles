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

M.telescope = {
   extensions = {
      -- fdfind is needed
      media_files = {
         filetypes = { "png", "webp", "jpg", "jpeg", "svg" },
      },
   },
}

return M
