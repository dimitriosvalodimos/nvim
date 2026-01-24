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
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/akinsho/bufferline.nvim",
	"https://github.com/blazkowolf/gruber-darker.nvim",
	"https://github.com/esmuellert/codediff.nvim",
	"https://github.com/folke/trouble.nvim",
	"https://github.com/ibhagwan/fzf-lua",
	"https://github.com/kylechui/nvim-surround",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/MeanderingProgrammer/render-markdown.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/rachartier/tiny-inline-diagnostic.nvim",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/windwp/nvim-autopairs",
	"https://github.com/Mofiqul/vscode.nvim",
	{ src = "https://github.com/saghen/blink.cmp", version = "v1.8.0" },
})
require("gruber-darker").setup({ italic = { strings = false, comments = false, operators = false, folds = false } })
require("vscode").setup({ italic_comments = false, italic_inlayhints = false })
require("bufferline").setup({
	options = {
		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(count, level)
			local icon = level:match("error") and " " or " "
			return " " .. icon .. count
		end,
	},
})
require("lualine").setup({ options = { section_separators = "", component_separators = "" } })
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
require("nvim-autopairs").setup({ disable_filetype = { "TelescopePrompt", "vim" } })
require("nvim-surround").setup({})
local blink = require("blink.cmp")
blink.setup({
	completion = { documentation = { auto_show = true } },
	fuzzy = { implementation = "lua" },
	keymap = { preset = "enter" },
	sources = { default = { "lsp", "path", "snippets", "buffer" } },
})
local servers = {
	"cssls",
	"eslint",
	"html",
	"lua_ls",
	"tsgo", -- npm i -g @typescript/native-preview
	-- "ts_ls",
}
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = blink.get_lsp_capabilities(capabilities)
require("tiny-inline-diagnostic").setup({
	preset = "classic",
	options = {
		add_messages = { display_count = true },
		multilines = { enabled = true },
		show_source = { if_many = true },
		show_all_diags_on_cursorline = false,
	},
})
vim.diagnostic.config({ virtual_text = false })
vim.lsp.config("*", { capabilities = capabilities })
vim.lsp.enable(servers)
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client:supports_method("textDocument/completion") then
			require("trouble").setup()
			map("n", "<leader>XX", "cmd>Trouble diagnostics toggle focus=true<cr>")
			map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>")
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
require("oil").setup({ view_options = { show_hidden = true }, columns = { "permissions", "size", "mtime" } })
local fzf = require("fzf-lua")
fzf.setup({ "skim", "border-fused", "fzf-native", "hide" })
fzf.register_ui_select()
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
require("codediff").setup()
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
require("render-markdown").setup({})
vim.cmd.colorscheme("vscode") -- gruber-darker, vscode
