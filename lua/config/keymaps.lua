local map = require("config.utils").map
map("v", "<", "<gv", "dedent")
map("v", ">", ">gv", "indent")
map("n", "n", "nzzzv", "center next match")
map("n", "N", "Nzzzv", "center previous match")
map("n", "<ESC>", ":nohlsearch<CR>", "toggle search highlight")
map("n", "<leader>v", ":vsplit<CR>", "vertical split")
map("n", "<leader>h", ":split<CR>", "horizontal split")
map("n", "<C-h>", "<C-w>h", "focus left pane")
map("n", "<C-j>", "<C-w>j", "focus bottom pane")
map("n", "<C-k>", "<C-w>k", "focus top pane")
map("n", "<C-l>", "<C-w>l", "focus right pane")
map("n", "<C-Up>", ":resize -2<CR>", "resize up")
map("n", "<C-Down>", ":resize +2<CR>", "resize down")
map("n", "<C-Left>", ":vertical resize -2<CR>", "resize left")
map("n", "<C-Right>", ":vertical resize +2<CR>", "resize right")
map("n", "<C-d>", "<C-d>zz", "center next page")
map("n", "<C-u>", "<C-u>zz", "center previous page")
map("i", "<A-u>", "<c-r>=trim(system('uuidgen'))<cr>", "uuid")
map("n", "<A-u>", "i<c-r>=trim(system('uuidgen'))<cr><esc>", "uuid")
map("n", "-", "<cmd>e .<cr>", "open file manager")
