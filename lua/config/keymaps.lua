-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>gL", function()
  require("fzf-lua").git_commits()
end, { desc = "Git Log" })

vim.keymap.set("n", "<leader>gb", function()
  require("fzf-lua").git_blame()
end, { desc = "Git Blame" })

vim.keymap.set("n", "<leader>gf", function()
  require("fzf-lua").git_bcommits()
end, { desc = "Git File History" })
