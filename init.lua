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
local map = vim.keymap.set
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
map("v", "<", "<gv")
map("v", ">", ">gv")
map("i", "<A-u>", "<c-r>=trim(system('uuidgen'))<cr>")
map("n", "<A-u>", "i<c-r>=trim(system('uuidgen'))<cr><esc>")
map("n", "K", vim.lsp.buf.hover)
map("n", "<leader>k", vim.diagnostic.open_float)
map("n", "-", "<cmd>Oil<cr>")
require("lazy").setup({
	{
		"scottmckendry/cyberdream.nvim",
		lazy = false,
		priority = 1000,
		opts = { borderless_pickers = true },
	},
	{
		"blazkowolf/gruber-darker.nvim",
		lazy = false,
		priority = 1000,
		opts = { italic = { strings = false, comments = false } },
	},
	{
		"nvim-tree/nvim-web-devicons",
		opts = { fast_wrap = {}, disable_filetype = { "TelescopePrompt", "vim" } },
	},
	{ "nvim-lualine/lualine.nvim", opts = {} },
	{
		"lewis6991/gitsigns.nvim",
		lazy = false,
		opts = {
			current_line_blame = true,
			current_line_blame_opts = { virt_text_pos = "right_align" },
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			signs_staged = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
			},
		},
	},
	{
		"stevearc/oil.nvim",
		opts = { columns = { "permissions", "size", "mtime" }, view_options = { show_hidden = true } },
		keys = { { "-", ":Oil<cr>" } },
	},
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				auto_install = true,
				highlight = { enable = true, additional_vim_regex_highlighting = false, use_languagetree = true },
				ensure_installed = { "diff", "lua", "luadoc", "markdown", "markdown_inline", "vimdoc" },
			})
		end,
	},
	{ "windwp/nvim-autopairs", event = "InsertEnter", config = true },
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = { library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } } } },
	},
	{
		"saghen/blink.cmp",
		version = "1.*",
		event = "InsertEnter",
		dependencies = { "rafamadriz/friendly-snippets" },
		opts = {
			signature = { enabled = true },
			fuzzy = { implementation = "prefer_rust" },
			appearance = { nerd_font_variant = "normal" },
			completion = { documentation = { auto_show = true } },
			sources = {
				default = { "lazydev", "lsp", "path", "snippets", "buffer" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
				},
			},
			keymap = {
				preset = "enter",
				["<Tab>"] = { "select_next", "fallback" },
				["<S-Tab>"] = { "select_prev", "fallback" },
			},
		},
	},
	{
		"mason-org/mason.nvim",
		dependencies = {
			"saghen/blink.cmp",
			"neovim/nvim-lspconfig",
			"zapling/mason-conform.nvim",
			"mason-org/mason-lspconfig.nvim",
		},
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())
			vim.lsp.config("*", { capabilities = capabilities })
			vim.diagnostic.config({ severity_sort = true, virtual_lines = false, virtual_text = true })
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "cssls", "html", "lua_ls", "ts_ls" },
				automatic_enable = true,
			})
			require("mason-conform").setup({})
		end,
	},
	{
		"ibhagwan/fzf-lua",
		opts = { { "ivy", "hide" } },
		keys = {
			{ "<leader>ff", ":FzfLua files<cr>" },
			{ "<leader>fg", ":FzfLua live_grep<cr>" },
			{ "<leader>fb", ":FzfLua buffers<cr>" },
			{ "<leader>fr", ":FzfLua resume<cr>" },
			{ "<leader>/", ":FzfLua grep_curbuf<cr>" },
			{ "<leader>xx", ":FzfLua diagnostics_document<cr>" },
		},
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "sindrets/diffview.nvim", cmd = "DiffviewOpen", opts = {} },
			"ibhagwan/fzf-lua",
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
	checker = { enabled = true },
})
vim.cmd.colorscheme("cyberdream") -- gruber-darker, cyberdream, default
