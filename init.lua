local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)
local g = vim.g
local opt = vim.opt
g.mapleader = " "
g.maplocalleader = ";"
opt.backupcopy = "yes"
opt.breakindent = true
opt.clipboard:append("unnamedplus")
opt.completeopt = { "menu", "menuone", "noselect" }
opt.cursorline = true
opt.expandtab = true
opt.grepprg = "rg --vimgrep --no-heading --smart-case"
opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
opt.ignorecase = true
opt.inccommand = "nosplit"
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
opt.updatetime = 500
opt.wrap = false
local function map(mode, lhs, rhs, opts)
	if type(opts) == "string" then
		vim.keymap.set(mode, lhs, rhs, { desc = opts })
	else
		vim.keymap.set(mode, lhs, rhs, opts)
	end
end
local diagnostic_config = { severity_sort = true, virtual_lines = false, virtual_text = true }
map("v", "<", "<gv", "dedent")
map("v", ">", ">gv", "indent")
map("i", "<A-u>", "<c-r>=trim(system('uuidgen'))<cr>", "uuid")
map("n", "<A-u>", "i<c-r>=trim(system('uuidgen'))<cr><esc>", "uuid")
map("n", "K", vim.lsp.buf.hover, "hover")
map("n", "<leader>k", vim.diagnostic.open_float, "diagnostics")
require("lazy").setup({
	{
		"lewis6991/gitsigns.nvim",
		lazy = false,
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
		keys = { { "<leader>gs", ":Gitsigns toggle_current_line_blame<cr>", desc = "git blame" } },
	},
	{
		"stevearc/oil.nvim",
		opts = { "icon", "permissions", "size", "mtime" },
		keys = { { "-", "<cmd>Oil<cr>", "open parent dir" } },
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = { disable_filetype = { "TelescopePrompt", "vim" }, map_cr = true, enable_check_bracket_line = false },
	},
	{
		"saghen/blink.cmp",
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "1.*",
		opts = {
			keymap = { preset = "enter" },
			completion = { documentation = { auto_show = true } },
			signature = { enabled = true },
			sources = { default = { "lsp", "path", "snippets", "buffer" } },
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.install").prefer_git = true
			require("nvim-treesitter.configs").setup({
				auto_install = true,
				ensure_installed = { "diff", "lua", "luadoc", "markdown", "markdown_inline", "vimdoc" },
				highlight = { enable = true, additional_vim_regex_highlighting = false },
			})
		end,
	},
	{
		"ibhagwan/fzf-lua",
		opts = {},
		keys = {
			{ "<leader>ff", ":silent FzfLua files<cr>", desc = "find files" },
			{ "<leader>/", ":silent FzfLua grep_curbuf<cr>", desc = "in buffer" },
			{ "<leader>fr", ":silent FzfLua resume<cr>", desc = "resume search" },
			{ "<leader>fb", ":silent FzfLua buffers<cr>", desc = "find buffer" },
			{ "<leader>fg", ":silent FzfLua live_grep<cr>", desc = "find word" },
		},
	},
	{
		"stevearc/conform.nvim",
		opts = {
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
		},
	},
	{
		"mason-org/mason.nvim",
		dependencies = {
			"saghen/blink.cmp",
			"nvim-lua/plenary.nvim",
			"neovim/nvim-lspconfig",
			"zapling/mason-conform.nvim",
			"pmizio/typescript-tools.nvim",
			"mason-org/mason-lspconfig.nvim",
		},
		config = function()
			local servers = { "cssls", "html", "lua_ls" }
			local cap = require("blink.cmp").get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())
			vim.lsp.config("*", { capabilities = cap })
			vim.diagnostic.config(diagnostic_config)
			require("typescript-tools").setup({
				complete_function_calls = true, -- npm i -g @styled/typescript-styled-plugin typescript-styled-plugin
				settings = { tsserver_plugins = { "@styled/typescript-styled-plugin" } },
			})
			require("mason").setup()
			require("mason-lspconfig").setup({ ensure_installed = servers, automatic_enable = true })
			require("mason-conform").setup({})
			map("n", "gd", vim.lsp.buf.definition, {})
			map("n", "gD", vim.lsp.buf.declaration, {})
		end,
	},
	{ "kevinhwang91/nvim-bqf", ft = "qf", dependencies = { "nvim-treesitter/nvim-treesitter" } },
})
vim.cmd.colorscheme("default") -- default, lunaperche, retrobox, slate, sorbet
-- MasonInstall css-lsp html-lsp typescript-language-server lua-language-server stylua prettier
