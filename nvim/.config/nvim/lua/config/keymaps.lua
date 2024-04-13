-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
---- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- diffview
vim.keymap.set(
  "n",
  "<leader>gdc",
  "<cmd>set hidden<cr><cmd>DiffviewClose<cr><cmd>set nohidden<cr>",
  { desc = "close Diffview" }
)
vim.keymap.set("n", "<leader>gdo", "<cmd>DiffviewOpen<cr>", { desc = "Open Diffview" })
vim.keymap.set("n", "<leader>gdfc", "<cmd>DiffviewFileHistory %<cr>", { desc = "FileHistory current branch" })
vim.keymap.set("n", "<leader>gdfb", "<cmd>DiffviewFileHistory<cr>", { desc = "FileHistory current file" })

-- codeSnap
vim.keymap.set("v", "<leader>cp", "<cmd>'<,'>CodeSnap<cr>", { desc = "code screenshot" })
