local g = vim.g
local opt = vim.opt
g.mapleader = " "
opt.clipboard = "unnamedplus"
opt.completeopt = { "menuone", "noselect", "popup", "fuzzy" }
opt.expandtab = true
opt.ignorecase = true
opt.incsearch = true
opt.infercase = true
opt.mouse = "a"
opt.number = true
opt.relativenumber = true
opt.shiftwidth = 0
opt.smartcase = true
opt.smartindent = true
opt.smarttab = true
opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true
opt.tabstop = 4
opt.termguicolors = true
opt.undofile = true
opt.undolevels = 10000
opt.wrap = false
opt.writebackup = false
vim.cmd("filetype plugin indent on")
vim.cmd("packadd nohlsearch")
vim.cmd("packadd nvim.difftool")
vim.cmd("packadd nvim.undotree")
require("vim._core.ui2").enable({})
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
local map = vim.keymap.set
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
	{ src = gh("kylechui/nvim-surround"), version = "v4.0.5" },
	{ src = gh("lewis6991/gitsigns.nvim"), version = "v2.1.0" },
	{ src = gh("neovim/nvim-lspconfig"), version = "v2.10.0" },
	{ src = gh("nvim-lualine/lualine.nvim"), commit = "221ce6b2d999187044529f49da6554a92f740a96" },
	{ src = gh("nvim-treesitter/nvim-treesitter"), commit = "4916d6592ede8c07973490d9322f187e07dfefac" },
	{ src = gh("stevearc/conform.nvim"), version = "v9.1.0" },
	{ src = gh("stevearc/oil.nvim"), version = "v2.16.0" },
	{ src = gh("windwp/nvim-autopairs"), commit = "7b9923abad60b903ece7c52940e1321d39eccc79" },
})
require("nvim-autopairs").setup({ disable_filetype = { "TelescopePrompt", "vim" } })
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
		local language = vim.treesitter.language.get_lang(args.match) or args.match
		if not vim.treesitter.language.add(language) then
			return
		end
		vim.treesitter.start(args.buf, language)
		vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})
require("nvim-surround").setup({})
require("gitsigns").setup({ current_line_blame = true, current_line_blame_opts = { virt_text_pos = "right_align" } })
local servers = { "biome", "cssls", "eslint", "html", "lua_ls", "tsgo" }
local capabilities = vim.lsp.protocol.make_client_capabilities()
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
	callback = function(ev)
		local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
		if client:supports_method("textDocument/completion") then
			local chars = {}
			for i = 32, 126 do
				table.insert(chars, string.char(i))
			end
			client.server_capabilities.completionProvider.triggerCharacters = chars
		end
		vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
	end,
})
vim.lsp.config("*", { capabilities = capabilities })
vim.lsp.enable(servers)
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
map("n", "<leader>bd", "<cmd>enew<bar>bd #<cr>")
map("n", "<Esc>", "<cmd>noh<CR>")
map("n", "<A-u>", "i<c-r>=trim(system('uuidgen'))<cr><esc>")
map("i", "<A-u>", "<c-r>=trim(system('uuidgen'))<cr>")
local group = vim.api.nvim_create_augroup("config_group", {})
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
vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	group = group,
	callback = function()
		vim.hl.hl_op()
	end,
})
