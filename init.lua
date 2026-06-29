local g = vim.g
local opt = vim.opt
g.mapleader = " "
opt.clipboard = "unnamedplus"
opt.cursorline = true
opt.expandtab = true
opt.ignorecase = true
opt.incsearch = true
opt.infercase = true
opt.mouse = "a"
opt.number = true
opt.relativenumber = true
opt.shiftwidth = 0
opt.signcolumn = "yes"
opt.smartcase = true
opt.smartindent = true
opt.smarttab = true
opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true
opt.tabstop = 4
opt.termguicolors = true
opt.undofile = true
opt.wrap = false
opt.writebackup = false
vim.cmd("filetype plugin indent on")
vim.cmd("packadd nohlsearch")
vim.cmd("packadd nvim.difftool")
vim.cmd("packadd nvim.undotree")
require("vim._core.ui2").enable({})
local gh = function(pkg)
	return "https://github.com/" .. pkg
end
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "nvim-treesitter" and kind == "update" then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		end
	end,
})
vim.pack.add({
	{ src = gh("ibhagwan/fzf-lua"), commit = "267f5db2aa2202b9f6cc7a50783f0ccd2121766c" },
	{ src = gh("kylechui/nvim-surround"), version = "v4.0.5" },
	{ src = gh("lewis6991/gitsigns.nvim"), version = "v2.1.0" },
	{ src = gh("neovim/nvim-lspconfig"), version = "v2.10.0" },
	{ src = gh("nvim-lualine/lualine.nvim"), commit = "221ce6b2d999187044529f49da6554a92f740a96" },
	{ src = gh("nvim-treesitter/nvim-treesitter"), commit = "4916d6592ede8c07973490d9322f187e07dfefac" },
	{ src = gh("rachartier/tiny-inline-diagnostic.nvim"), commit = "e930d0a46031645040d5492595b46cdf6ab3514f" },
	{ src = gh("saghen/blink.cmp"), version = "v1.10.2" },
	{ src = gh("stevearc/conform.nvim"), version = "v9.1.0" },
	{ src = gh("stevearc/oil.nvim"), version = "v2.16.0" },
	{ src = gh("windwp/nvim-autopairs"), commit = "7b9923abad60b903ece7c52940e1321d39eccc79" },
})
local filetypes = {
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
}
require("lualine").setup({})
local already_installed = require("nvim-treesitter.config").get_installed()
local to_install = vim.iter(filetypes)
	:filter(function(p)
		return not vim.tbl_contains(already_installed, p)
	end)
	:totable()
require("nvim-treesitter").install(to_install)
vim.api.nvim_create_autocmd("FileType", {
	pattern = filetypes,
	callback = function(args)
		local buf = args.buf
		local filetype = args.match
		local language = vim.treesitter.language.get_lang(filetype) or filetype
		if not vim.treesitter.language.add(language) then
			return
		end
		vim.treesitter.start(buf, language)
		vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})
local map = vim.keymap.set
require("nvim-autopairs").setup({ disable_filetype = { "TelescopePrompt", "vim" } })
require("nvim-surround").setup({})
local blink = require("blink.cmp")
blink.setup({
	completion = { documentation = { auto_show = true } },
	fuzzy = { implementation = "prefer_rust_with_warning" },
	keymap = { preset = "enter" },
	sources = { default = { "lsp", "path", "snippets", "buffer" } },
})
local servers = {
	"biome",
	"cssls",
	"eslint",
	"html",
	"lua_ls",
	"tsgo",
}
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = blink.get_lsp_capabilities(capabilities)
vim.lsp.config("*", { capabilities = capabilities })
vim.lsp.enable(servers)
require("tiny-inline-diagnostic").setup({
	options = { add_messages = { display_count = true }, multilines = { enabled = true } },
})
vim.diagnostic.config({ virtual_text = false })
local webFormatters = { "biome-check", "prettier", stop_at_first = true }
local conform = require("conform")
conform.setup({
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
	formatters_by_ft = {
		css = webFormatters,
		html = webFormatters,
		javascript = webFormatters,
		javascriptreact = webFormatters,
		json = webFormatters,
		lua = { "stylua" },
		typescript = webFormatters,
		typescriptreact = webFormatters,
	},
})
require("oil").setup({ view_options = { show_hidden = true }, columns = { "permissions", "size", "mtime" } })
local fzf = require("fzf-lua")
fzf.setup({ "hide" })
fzf.register_ui_select()
require("gitsigns").setup({
	numhl = true,
	current_line_blame = true,
	current_line_blame_opts = { virt_text_pos = "right_align" },
})
map("i", "<A-u>", "<c-r>=trim(system('uuidgen'))<cr>")
map("n", "<A-u>", "i<c-r>=trim(system('uuidgen'))<cr><esc>")
map("n", "-", ":Oil<cr>")
map("n", "<Esc>", "<cmd>noh<CR>")
map("n", "<leader>/", ":FzfLua grep_curbuf<cr>")
map("n", "<leader>bd", "<cmd>enew<bar>bd #<cr>")
map("n", "<leader>fb", ":lua require('fzf-lua').buffers()<cr>")
map("n", "<leader>ff", ":lua require('fzf-lua').files()<cr>")
map("n", "<leader>fg", ":lua require('fzf-lua').live_grep_native()<cr>")
map("n", "<leader>fh", ":lua require('fzf-lua').helptags()<cr>")
map("n", "<leader>fk", ":lua require('fzf-lua').keymaps()<cr>")
map("n", "<leader>fR", ":lua require('fzf-lua').registers()<cr>")
map("n", "<leader>fr", ":lua require('fzf-lua').resume()<cr>")
map("n", "<leader>xx", ":lua require('fzf-lua').diagnostics_document()<cr>")
map("n", "<leader>XX", ":lua require('fzf-lua').diagnostics_workspace()<cr>")
map("n", "gd", ":lua require('fzf-lua').lsp_definitions()<cr>")
map("n", "gra", ":lua require('fzf-lua').lsp_code_actions()<cr>")
map("n", "grr", ":lua require('fzf-lua').lsp_references()<cr>")
map("n", "<leader>co", function()
	vim.lsp.buf.code_action({
		apply = true,
		context = { only = { "source.organizeImports" }, diagnostics = {} },
	})
end)
map({ "x", "o" }, "v", function()
	if vim.treesitter.get_parser(nil, nil, { error = false }) then
		require("vim.treesitter._select").select_parent(vim.v.count1)
	else
		vim.lsp.buf.selection_range(vim.v.count1)
	end
end)
map({ "x", "o" }, "V", function()
	if vim.treesitter.get_parser(nil, nil, { error = false }) then
		require("vim.treesitter._select").select_child(vim.v.count1)
	else
		vim.lsp.buf.selection_range(-vim.v.count1)
	end
end)
local group = vim.api.nvim_create_augroup("config_group", {})
vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	group = group,
	callback = function()
		vim.hl.hl_op()
	end,
})
