local map = require("config.utils").map
map("v", "<", "<gv", "dedent")
map("v", ">", ">gv", "indent")
map("n", "n", "nzzzv", "center next match")
map("n", "N", "Nzzzv", "center previous match")
map("i", "<A-u>", "<c-r>=trim(system('uuidgen'))<cr>", "uuid")
map("n", "<A-u>", "i<c-r>=trim(system('uuidgen'))<cr><esc>", "uuid")
map("n", "-", ":Explore %:p:h<cr>", "open file manager")
