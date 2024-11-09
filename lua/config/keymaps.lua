local map = require("config.utils").map
map("v", "<", "<gv", "dedent")
map("v", ">", ">gv", "indent")
map("n", "<TAB>", ":bn<CR>", "next tab")
map("n", "<S-TAB>", ":bp<CR>", "previous tab")
map("n", "n", "nzzzv", "center next match")
map("n", "N", "Nzzzv", "center previous match")
map("n", "<c-h>", "<c-w><c-h>", "focus left window")
map("n", "<c-l>", "<c-w><c-l>", "focus right window")
map("n", "<c-j>", "<c-w><c-j>", "focus lower window")
map("n", "<c-k>", "<c-w><c-k>", "focus upper window")
map("n", "<C-Up>", ":resize -2<CR>", "resize up")
map("n", "<C-Down>", ":resize +2<CR>", "resize down")
map("n", "<C-Left>", ":vertical resize -2<CR>", "resize left")
map("n", "<C-Right>", ":vertical resize +2<CR>", "resize right")
map("n", "<C-d>", "<C-d>zz", "center next page")
map("n", "<C-u>", "<C-u>zz", "center previous page")
map("n", "<A-j>", ":m .+1<CR>==", "move line up")
map("n", "<A-k>", ":m .-2<CR>==", "move line down")
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", "move line up")
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", "move line down")
map("i", "<A-u>", "<c-r>=trim(system('uuidgen'))<cr>", "uuid")
map("n", "<A-u>", "i<c-r>=trim(system('uuidgen'))<cr><esc>", "uuid")
