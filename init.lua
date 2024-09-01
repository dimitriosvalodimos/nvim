local g = vim.g
local opt = vim.opt
g.mapleader = " "
g.maplocalleader = ","
opt.backupcopy = "yes"
opt.background = "dark"
opt.breakindent = true
opt.clipboard = "unnamedplus"
opt.completeopt = { "menu", "menuone", "noselect", "popup" }
opt.conceallevel = 0 -- don't hide bold/italic markers
opt.confirm = true -- ask to save changes
opt.copyindent = true
opt.cursorline = true
opt.diffopt = vim.list_extend(vim.opt.diffopt:get(), { "algorithm:histogram", "linematch:60" })
opt.expandtab = true
opt.foldcolumn = "1"
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99 -- start with all code unfolded
opt.hlsearch = true
opt.ignorecase = true -- case insensitive searching
opt.inccommand = "nosplit" -- preview substitute
opt.infercase = true -- infer cases in keyword completion
opt.laststatus = 3 -- global statusline
opt.number = true
opt.numberwidth = 4
opt.preserveindent = true
opt.pumblend = 10 -- popup blend
opt.pumheight = 10 -- popup max height
opt.relativenumber = true
opt.scrolloff = 5 -- vertical buffer area on scroll
opt.shiftround = true
opt.shiftwidth = 2
-- opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.sidescrolloff = 5 -- horizontal buffer area on scroll
opt.signcolumn = "yes" -- Always show the signcolumn
opt.smartcase = true
opt.smartindent = true
opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true
opt.tabstop = 2
opt.termguicolors = true
opt.updatetime = 300
opt.timeoutlen = 300
opt.timeout = true
opt.title = true
opt.undofile = true
opt.undolevels = 10000
opt.virtualedit = "block"
opt.wildmode = { "longest:full", "full" }
opt.wrap = false

if vim.fn.has("nvim-0.10") == 1 then
	opt.smoothscroll = true
	opt.foldmethod = "expr"
	opt.foldtext = ""
end
local disabled_plugins = {
	"2html_plugin",
	"tohtml",
	"getscript",
	"getscriptPlugin",
	"gzip",
	"logipat",
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"matchit",
	"tar",
	"tarPlugin",
	"rrhelper",
	"spellfile_plugin",
	"vimball",
	"vimballPlugin",
	"zip",
	"zipPlugin",
	"tutor",
	"rplugin",
	"syntax",
	"synmenu",
	"optwin",
	"compiler",
	"bugreport",
	"ftplugin",
}
for i = 1, #disabled_plugins do
	g["loaded_" .. disabled_plugins[i]] = true
end
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", {}),
	desc = "Highlight selection on yank",
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
	end,
})
vim.keymap.set("i", "<c-u>", "<c-r>=trim(system('uuidgen'))<cr>", { desc = "insert uuid at cursor" })
vim.keymap.set("n", "<c-u>", "i<c-r>=trim(system('uuidgen'))<cr><esc>", { desc = "insert uuid at cursor" })
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "move line up" })
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "move line down" })
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "move line up" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "move line down" })
vim.keymap.set("v", "<", "<gv", { desc = "dedent" })
vim.keymap.set("v", ">", ">gv", { desc = "indent" })
vim.keymap.set("i", "<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { noremap = true, expr = true })
vim.keymap.set("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { noremap = true, expr = true })

require("config.lazy")

-- poimandres, substrata, iceberg, oh-lucy, oh-lucy-evening, vesper, no-clown-fiesta, aura, oxocarbon
vim.cmd.colorscheme("oxocarbon")
