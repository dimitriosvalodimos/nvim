local g = vim.g
local opt = vim.opt
g.mapleader = " "
opt.backup = false
opt.clipboard = "unnamedplus"
opt.completeopt = { "menu", "menuone", "noinsert" }
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
	"https://github.com/ibhagwan/fzf-lua",
	"https://github.com/Mofiqul/vscode.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/nvim-mini/mini.nvim",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/stevearc/oil.nvim",
})
require("mini.icons").setup()
require("mini.statusline").setup()
require("mini.tabline").setup()
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
local map = vim.keymap.set
require("mini.git").setup()
require("mini.diff").setup({ view = { style = "sign", signs = { add = "+", change = "~", delete = "_" } } })
require("mini.pairs").setup()
require("mini.completion").setup()
local servers = { "cssls", "eslint", "html", "lua_ls", "ts_ls" }
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
vim.diagnostic.config({ severity_sort = true, virtual_text = true })
vim.lsp.config("*", { capabilities = capabilities })
vim.lsp.enable(servers)
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client:supports_method("textDocument/completion") then
			map("n", "<leader>XX", ":FzfLua diagnostics_document<cr>")
			map("n", "<leader>xx", ":FzfLua diagnostics_workspace<cr>")
			map("n", "grc", ":FzfLua lsp_code_actions<cr>")
			map("n", "gd", ":FzfLua lsp_definitions<cr>")
			map("n", "gri", ":FzfLua lsp_implementations<cr>")
			map("n", "grr", ":FzfLua lsp_references<cr>")
			map("n", "grt", ":FzfLua lsp_typedefs<cr>")
			map("n", "grn", vim.lsp.buf.rename)
		end
	end,
})
vim.diagnostic.config({ severity_sort = true })
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
map("n", "-", ":Oil<cr>")
map("n", "<A-u>", "i<c-r>=trim(system('uuidgen'))<cr><esc>")
map("n", "<c-h>", "<c-w>h")
map("n", "<c-j>", "<c-w>j")
map("n", "<c-k>", "<c-w>k")
map("n", "<c-l>", "<c-w>l")
map("n", "<Esc>", "<cmd>noh<CR>")
map("n", "<leader>/", ":FzfLua grep_curbuf<cr>")
map("n", "<leader>fb", ":FzfLua buffers<cr>")
map("n", "<leader>ff", ":FzfLua files<cr>")
map("n", "<leader>fg", ":FzfLua live_grep_native<cr>")
map("n", "<leader>fh", ":FzfLua helptags<cr>")
map("n", "<leader>fk", ":FzfLua keymaps<cr>")
map("n", "<leader>fo", ":FzfLua oldfiles<cr>")
map("n", "<leader>fR", ":FzfLua registers<cr>")
map("n", "<leader>fr", ":FzfLua resume<cr>")
map("i", "<A-u>", "<c-r>=trim(system('uuidgen'))<cr>")
map("i", "<c-b>", "<ESC>^i")
map("i", "<c-e>", "<End>")
map({ "i", "x", "n", "s" }, "<c-s>", "<cmd>w<cr><esc>")
local group = vim.api.nvim_create_augroup("config_group", {})
local au = function(event, pattern, callback, desc)
	vim.api.nvim_create_autocmd(event, { group = group, pattern = pattern, callback = callback, desc = desc })
end
au("TextYankPost", "*", function()
	vim.hl.on_yank()
end)
local hipatterns = require("mini.hipatterns")
hipatterns.setup({
	highlighters = {
		fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
		hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
		todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
		note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
		hex_color = hipatterns.gen_highlighter.hex_color(),
	},
})
require("vscode").setup({ italic_comments = false })
vim.cmd.colorscheme("vscode") -- vscode
