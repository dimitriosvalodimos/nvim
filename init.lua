require("config.options")
require("config.keymaps")
require("config.lazy")
require("config.cmds")
vim.cmd.colorscheme("gruber-darker") -- gruber-darker, no-clown-fiesta, poimandres
vim.api.nvim_set_hl(0, "MiniPickMatchCurrent", { link = "Visual" })
