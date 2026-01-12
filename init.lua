local g = vim.g
local opt = vim.opt
g.mapleader = " "
opt.backup = false
opt.clipboard = "unnamedplus"
opt.completeopt = { "menu", "menuone", "noinsert", "fuzzy" }
opt.cursorline = true
opt.expandtab = true
opt.ignorecase = true
opt.incsearch = true
opt.infercase = true
opt.mouse = "a"
opt.number = true
opt.pumheight = 10
opt.ruler = false
opt.shiftwidth = 4
opt.shortmess:append("WcC")
opt.showmode = false
opt.signcolumn = "yes"
opt.smartcase = true
opt.smartindent = true
opt.softtabstop = 2
opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true
opt.tabstop = 4
opt.termguicolors = true
opt.undofile = true
opt.virtualedit = "block"
opt.wrap = false
opt.writebackup = false
vim.cmd("filetype plugin indent on")
vim.pack.add({
	"https://github.com/akinsho/toggleterm.nvim",
	"https://github.com/blazkowolf/gruber-darker.nvim",
	"https://github.com/ibhagwan/fzf-lua",
	"https://github.com/kylechui/nvim-surround",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/mfussenegger/nvim-lint",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/projekt0n/github-nvim-theme",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/windwp/nvim-autopairs",
	"https://github.com/olivercederborg/poimandres.nvim",
	{ src = "https://github.com/saghen/blink.cmp", version = "v1.8.0" },
})
require("gruber-darker").setup({ italic = { strings = false, comments = false, operators = false, folds = false } })
require("poimandres").setup({ disable_italics = true })
require("lualine").setup({ options = { section_separators = "", component_separators = "" } })
require("nvim-autopairs").setup({ disable_filetype = { "TelescopePrompt", "vim" } })
require("gitsigns").setup({
	current_line_blame = true,
	current_line_blame_opts = { virt_text_pos = "right_align" },
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
})
require("nvim-treesitter").install({
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
})
local map = vim.keymap.set
local blink = require("blink.cmp")
blink.setup({
	completion = { documentation = { auto_show = true } },
	fuzzy = { implementation = "lua" },
	keymap = { preset = "enter" },
	sources = { default = { "lsp", "path", "snippets", "buffer" } },
})
local servers = {
	"cssls",
	"html",
	"lua_ls",
	"tsgo", -- npm i -g @typescript/native-preview
	-- "ts_ls",
}
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = blink.get_lsp_capabilities(capabilities)
vim.diagnostic.config({
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	underline = { severity = vim.diagnostic.severity.ERROR },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
	},
	virtual_text = true,
})
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
local prettier = { "prettier" }
local eslint = { "eslint" }
local conform = require("conform")
conform.setup({
	formatters_by_ft = {
		css = prettier,
		html = prettier,
		javascript = prettier,
		javascriptreact = prettier,
		json = prettier,
		lua = { "stylua" },
		typescript = prettier,
		typescriptreact = prettier,
	},
})
local lint = require("lint")
lint.linters_by_ft = {
	css = eslint,
	html = eslint,
	javascript = eslint,
	javascriptreact = eslint,
	json = eslint,
	typescript = eslint,
	typescriptreact = eslint,
}
require("oil").setup({ view_options = { show_hidden = true }, columns = { "permissions", "size", "mtime" } })
local fzf = require("fzf-lua")
fzf.setup({ "skim", "border-fused", "fzf-native", "hide" })
fzf.register_ui_select()
require("nvim-surround").setup({})
require("toggleterm").setup({ open_mapping = [[<c-t>]], shell = "fish" })
map("n", "<leader>/", ":FzfLua grep_curbuf<cr>")
map("n", "<leader>fr", ":FzfLua resume<cr>")
map("n", "<leader>fb", ":FzfLua buffers<cr>")
map("n", "<leader>ff", ":FzfLua files<cr>")
map("n", "<leader>fg", ":FzfLua live_grep_native<cr>")
map("n", "<leader>fh", ":FzfLua helptags<cr>")
map("n", "<leader>fk", ":FzfLua keymaps<cr>")
map("n", "<leader>fo", ":FzfLua oldfiles<cr>")
map("n", "<leader>fR", ":FzfLua registers<cr>")
map("n", "-", ":Oil<cr>")
map("n", "<c-h>", "<c-w>h")
map("n", "<c-j>", "<c-w>j")
map("n", "<c-k>", "<c-w>k")
map("n", "<c-l>", "<c-w>l")
map("n", "<Esc>", "<cmd>noh<CR>")
map("n", "<A-u>", "i<c-r>=trim(system('uuidgen'))<cr><esc>")
map("i", "<A-u>", "<c-r>=trim(system('uuidgen'))<cr>")
map("i", "<c-b>", "<ESC>^i")
map("i", "<c-e>", "<End>")
map({ "i", "x", "n", "s" }, "<c-s>", function()
	local bufnr = vim.api.nvim_get_current_buf()
	if vim.fn.mode() == "i" then
		vim.cmd("stopinsert")
	end

	conform.format({ bufnr = bufnr, lsp_format = true, async = false, stop_after_first = true })

	if vim.bo.modified then
		vim.cmd("write")
	end
end)
local group = vim.api.nvim_create_augroup("config_group", {})
local au = function(event, pattern, callback, desc)
	vim.api.nvim_create_autocmd(event, { group = group, pattern = pattern, callback = callback, desc = desc })
end
au("TextYankPost", "*", function()
	vim.hl.on_yank()
end)
au({ "BufEnter", "BufWritePost", "InsertLeave" }, { "*" }, function()
	lint.try_lint(nil, { ignore_errors = true })
end)
au("FileType", { "<filetype>" }, function(args)
	local buf = args.buf
	local filetype = args.match
	local language = vim.treesitter.language.get_lang(filetype) or filetype
	if not vim.treesitter.language.add(language) then
		return
	end
	vim.treesitter.start(buf, language)
	vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end)
vim.cmd.colorscheme("poimandres") -- wildcharm, koehler, industry, torte, github_dark_default, gruber-darker, poimandres
