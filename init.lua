local g = vim.g
local opt = vim.opt
g.mapleader = " "
opt.backupcopy = "yes"
opt.breakindent = true
opt.clipboard:append("unnamedplus")
opt.completeopt = { "menu", "menuone", "noselect" }
opt.cursorline = true
opt.expandtab = true
opt.ignorecase = true
opt.infercase = true
opt.laststatus = 2
opt.number = true
opt.preserveindent = true
opt.pumheight = 10
opt.shiftround = true
opt.shiftwidth = 2
opt.shortmess = "c"
opt.signcolumn = "yes"
opt.smartcase = true
opt.smartindent = true
opt.splitbelow = true
opt.splitright = true
opt.tabstop = 2
opt.termguicolors = true
opt.wrap = false
local function map(mode, lhs, rhs, opts)
	vim.keymap.set(mode, lhs, rhs, opts)
end
map("v", "<", "<gv")
map("v", ">", ">gv")
map("i", "<A-u>", "<c-r>=trim(system('uuidgen'))<cr>")
map("n", "<A-u>", "i<c-r>=trim(system('uuidgen'))<cr><esc>")
map("n", "K", vim.lsp.buf.hover)
map("n", "<leader>k", vim.diagnostic.open_float)
map("n", "-", "<cmd>Oil<cr>")
map("i", "<CR>", function()
	if vim.fn.complete_info()["selected"] ~= -1 then
		return "<C-y>"
	end
	if vim.fn.pumvisible() ~= 0 then
		return "<C-e><CR>"
	end
	return "<CR>"
end, { expr = true })
map("i", "<Tab>", function()
	if vim.fn.pumvisible() ~= 0 then
		return "<C-n>"
	end
	return "<Tab>"
end, { expr = true })
map("i", "<S-Tab>", function()
	if vim.fn.pumvisible() ~= 0 then
		return "<C-p>"
	end
	return "<S-Tab>"
end, { expr = true })

vim.pack.add({
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/ibhagwan/fzf-lua",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/zapling/mason-conform.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/echasnovski/mini.nvim",
})
require("mini.tabline").setup({})
require("mini.statusline").setup({})
require("mini.pairs").setup({})
require("gitsigns").setup({ current_line_blame = true, current_line_blame_opts = { virt_text_pos = "right_align" } })
require("nvim-treesitter.configs").setup({
	auto_install = true,
	highlight = { enable = true, additional_vim_regex_highlighting = false },
	ensure_installed = { "diff", "lua", "luadoc", "markdown", "markdown_inline", "vimdoc" },
})
require("mini.completion").setup({})
require("oil").setup({ columns = { "permissions", "size", "mtime" }, view_options = { show_hidden = true } })
local capabilities = vim.lsp.protocol.make_client_capabilities()
vim.lsp.config("*", { capabilities = capabilities })
vim.diagnostic.config({ severity_sort = true, virtual_lines = false, virtual_text = true })
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "cssls", "html", "lua_ls", "gopls", "ts_ls" },
	automatic_enable = true,
})
require("mason-conform").setup({})
local fzf = require("fzf-lua")
fzf.setup({ { "skim", "max-perf", "ivy", "hide" } })
map("n", "<leader>ff", fzf.files)
map("n", "<leader>fb", fzf.buffers)
map("n", "<leader>fg", fzf.live_grep)
map("n", "<leader>fr", fzf.resume)
map("n", "<leader>/", fzf.grep_curbuf)
map("n", "<leader>xx", fzf.diagnostics_document)
require("conform").setup({
	format_on_save = { lsp_format = true, async = false, stop_after_first = true },
	formatters_by_ft = {
		css = { "prettier" },
		html = { "prettier" },
		javascript = { "prettier" },
		javascriptreact = { "prettier" },
		json = { "prettier" },
		lua = { "stylua" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
	},
})
