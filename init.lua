local g = vim.g
local opt = vim.opt
g.mapleader = " "
opt.backup = false
opt.clipboard = "unnamedplus"
opt.cursorline = true
opt.cursorlineopt = "number"
opt.expandtab = true
opt.ignorecase = true
opt.incsearch = true
opt.infercase = true
opt.mouse = "a"
opt.number = true
opt.pumheight = 10
opt.ruler = false
opt.shiftwidth = 2
opt.shortmess:append("WcC")
opt.showmode = false
opt.signcolumn = "yes"
opt.smartcase = true
opt.smartindent = true
opt.softtabstop = 2
opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true
opt.tabstop = 2
opt.termguicolors = true
opt.undofile = true
opt.virtualedit = "block"
opt.wrap = false
opt.writebackup = false
vim.cmd("filetype plugin indent on")
vim.pack.add({
	"https://github.com/folke/which-key.nvim",
	"https://github.com/ibhagwan/fzf-lua",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/Mofiqul/vscode.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/nyoom-engineering/oxocarbon.nvim",
	"https://github.com/projekt0n/github-nvim-theme",
	"https://github.com/rachartier/tiny-inline-diagnostic.nvim",
	"https://github.com/rafamadriz/friendly-snippets",
	"https://github.com/saghen/blink.download",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/windwp/nvim-ts-autotag",
	{ src = "https://github.com/saghen/blink.cmp", version = "v1.6.0" },
	{ src = "https://github.com/Saghen/blink.pairs", version = "v0.3.0" },
})
require("lualine").setup({ options = { section_separators = "", component_separators = "" } })
require("gitsigns").setup({
	current_line_blame = true,
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
})
require("nvim-treesitter.configs").setup({
	auto_install = true,
	highlight = { enable = true, additional_vim_regex_highlighting = false, use_languagetree = true },
	incremental_selection = { enable = true, keymaps = { node_incremental = "v", node_decremental = "V" } },
	ensure_installed = {
		"comment",
		"css",
		"diff",
		"html",
		"lua",
		"luadoc",
		"javascript",
		"jsdoc",
		"json",
		"json5",
		"markdown",
		"markdown_inline",
		"sql",
		"typescript",
		"vimdoc",
	},
})
require("nvim-ts-autotag").setup({})
require("blink.pairs").setup({})
local blink = require("blink.cmp")
blink.setup({
	completion = { documentation = { auto_show = true, window = { border = "single" } }, menu = { border = "single" } },
	fuzzy = { implementation = "lua" },
	keymap = { preset = "enter" },
	signature = { enabled = true, window = { border = "single" } },
})
local servers = { "cssls", "eslint", "html", "lua_ls", "ts_ls" }
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = blink.get_lsp_capabilities(capabilities)
vim.diagnostic.config({ severity_sort = true, virtual_text = false })
require("tiny-inline-diagnostic").setup({
	preset = "classic",
	options = { show_source = { enabled = true, if_many = true } },
})
vim.lsp.config("*", { capabilities = capabilities })
vim.lsp.enable(servers)
local prettier_or_biome = function(bufnr)
	local biome = require("conform").get_formatter_info("biome", bufnr)
	if biome.available then
		return { "biome-check", "biome-organize-imports", stop_after_first = false }
	else
		return { "prettier" }
	end
end
require("conform").setup({
	format_on_save = { lsp_format = true, async = false, stop_after_first = true },
	formatters_by_ft = {
		css = prettier_or_biome,
		html = prettier_or_biome,
		javascript = prettier_or_biome,
		javascriptreact = prettier_or_biome,
		json = prettier_or_biome,
		lua = { "stylua" },
		typescript = prettier_or_biome,
		typescriptreact = prettier_or_biome,
	},
})
require("oil").setup({ view_options = { show_hidden = true }, columns = { "permissions", "size", "mtime" } })
local fzf = require("fzf-lua")
fzf.setup({ "border-fused", "fzf-native", "hide" })
fzf.register_ui_select()
local wk = require("which-key")
wk.setup({ delay = 0, preset = "helix" })
wk.add({
	{ "-", ":Oil<cr>" },
	{ "<A-u>", "i<c-r>=trim(system('uuidgen'))<cr><esc>", desc = "[u]uid" },
	{ "<c-h>", "<c-w>h" },
	{ "<c-j>", "<c-w>j" },
	{ "<c-k>", "<c-w>k" },
	{ "<c-l>", "<c-w>l" },
	{ "<Esc>", "<cmd>noh<CR>" },
	{ "<leader>/", ":FzfLua grep_curbuf<cr>", desc = "grep in buffer" },
	{ "<leader>d", group = "[d]iagnostic" },
	{ "<leader>dd", ":FzfLua diagnostics_document<cr>", desc = "[d]ocument" },
	{ "<leader>dw", ":FzfLua diagnostics_workspace<cr>", desc = "[w]orkspace" },
	{ "<leader>f", group = "[f]ind" },
	{ "<leader>fb", ":FzfLua buffers<cr>", desc = "[b]uffer" },
	{ "<leader>ff", ":FzfLua files<cr>", desc = "[f]ile" },
	{ "<leader>fg", ":FzfLua live_grep_native<cr>", desc = "[g]rep" },
	{ "<leader>fh", ":FzfLua helptags<cr>", desc = "[h]elptag" },
	{ "<leader>fk", ":FzfLua keymaps<cr>", desc = "[k]eymap" },
	{ "<leader>fo", ":FzfLua oldfiles<cr>", desc = "[o]ldfiles" },
	{ "<leader>fR", ":FzfLua registers<cr>", desc = "[R]egister" },
	{ "<leader>fr", ":FzfLua resume<cr>", desc = "[r]esume" },
	{ "gr", group = "[g]oto" },
	{ "grc", ":FzfLua lsp_code_actions<cr>", desc = "[c]ode action" },
	{ "grd", ":FzfLua lsp_definitions<cr>", desc = "[d]efinition" },
	{ "gri", ":FzfLua lsp_implementations<cr>", desc = "[i]mplementation" },
	{ "grn", vim.lsp.buf.rename, desc = "re[n]ame" },
	{ "grr", ":FzfLua lsp_references<cr>", desc = "[r]eference" },
	{ "grt", ":FzfLua lsp_typedefs<cr>", desc = "[t]ype definition" },
	{ mode = "i", "<A-u>", "<c-r>=trim(system('uuidgen'))<cr>", desc = "[u]uid" },
	{ mode = "i", "<c-b>", "<ESC>^i" },
	{ mode = "i", "<c-e>", "<End>" },
	{ mode = { "i", "x", "n", "s" }, "<c-s>", "<cmd>w<cr><esc>" },
})
local group = vim.api.nvim_create_augroup("config_group", {})
local au = function(event, pattern, callback, desc)
	vim.api.nvim_create_autocmd(event, { group = group, pattern = pattern, callback = callback, desc = desc })
end
au("TextYankPost", "*", function()
	vim.hl.on_yank()
end)
-- require("catppuccin").setup({ flavour = "mocha", term_colors = true, no_italic = true, auto_integrations = true })
-- require("vscode").setup({ italic_comments = false })
require("github-theme").setup({})
vim.cmd.colorscheme("github_dark_default") -- catppuccin, github_dark_default, oxocarbon, vscode
