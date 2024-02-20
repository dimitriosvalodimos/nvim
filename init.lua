local g = vim.g
local opt = vim.opt

g.mapleader = " "
g.maplocalleader = ","

opt.background = "dark"
opt.backspace:append({ "nostop" })
opt.breakindent = true
opt.clipboard = "unnamedplus"
opt.cmdheight = 0
opt.completeopt = { "menu", "menuone", "noselect" }
opt.conceallevel = 0
opt.copyindent = true
opt.cursorline = true
opt.diffopt:append("linematch:60")
opt.expandtab = true
opt.fileencoding = "utf-8"
opt.fillchars = { eob = " " }
opt.fillchars = {
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertleft = "┫",
  vertright = "┣",
  verthoriz = "╋",
}
opt.foldcolumn = "1"
opt.foldenable = true
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldmethod = "expr"
opt.guifont = "0xProto Nerd Font"
opt.hidden = true
opt.history = 1000
opt.hlsearch = true
opt.ignorecase = true
opt.infercase = true
opt.laststatus = 3
opt.linebreak = true
opt.mouse = "a"
opt.number = true
opt.preserveindent = true
opt.pumblend = 10
opt.pumheight = 10
opt.relativenumber = true
opt.ruler = false
opt.scrolloff = 8
opt.shiftwidth = 2
opt.shortmess:append({ s = true, I = true })
opt.showmode = false
opt.showtabline = 2
opt.sidescrolloff = 8
opt.signcolumn = "yes"
opt.smartcase = true
opt.smoothscroll = true
opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true
opt.tabstop = 2
opt.termguicolors = true
opt.timeoutlen = 500
opt.title = true
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 300
opt.viewoptions:remove("curdir")
opt.virtualedit = "block"
opt.wildmode = "longest:full,full"
opt.wrap = false
opt.writebackup = false

local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

-- calvera
-- citruszest
-- github_dark
-- github_dark_colorblind
-- github_dark_default
-- github_dark_dimmed
-- github_dark_high_contrast
-- github_dark_tritanopia
-- gruvbox
-- horizon
-- moonfly
-- nightfly
-- night-owl
-- oxocarbon
-- poimandres
-- rose-pine-main
-- rose-pine-moon
-- tokyodark
-- tokyonight-moon
-- tokyonight-night
-- tokyonight-storm
vim.cmd("colorscheme github_dark_default")
