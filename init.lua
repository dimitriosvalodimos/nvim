local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo(
			{ { "Failed to clone lazy.nvim:\n", "ErrorMsg" }, { out, "WarningMsg" }, { "\nPress any key to exit..." } },
			true,
			{}
		)
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)
local g = vim.g
local opt = vim.opt
g.mapleader = " "
opt.backupcopy = "yes"
opt.breakindent = true
opt.clipboard:append("unnamedplus")
opt.completeopt = { "menu", "menuone", "noselect" }
opt.expandtab = true
opt.ignorecase = true
opt.infercase = true
opt.laststatus = 2
opt.number = true
opt.relativenumber = true
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
	if type(opts) == "string" then
		vim.keymap.set(mode, lhs, rhs, { desc = opts })
	else
		vim.keymap.set(mode, lhs, rhs, opts)
	end
end
map("v", "<", "<gv", "dedent")
map("v", ">", ">gv", "indent")
map("i", "<A-u>", "<c-r>=trim(system('uuidgen'))<cr>", "uuid")
map("n", "<A-u>", "i<c-r>=trim(system('uuidgen'))<cr><esc>", "uuid")
map("n", "K", vim.lsp.buf.hover, "hover")
map("n", "<leader>k", vim.diagnostic.open_float, "diagnostics")
require("lazy").setup({
	{ "nvim-lualine/lualine.nvim", opts = {} },
	{ "akinsho/bufferline.nvim", version = "*", opts = {} },
	{
		"lewis6991/gitsigns.nvim",
		opts = {},
		lazy = false,
		keys = { { "<leader>gs", ":Gitsigns toggle_current_line_blame<cr>", desc = "git blame" } },
	},
	{
		"stevearc/oil.nvim",
		opts = { columns = { "icon", "permissions", "size", "mtime" }, view_options = { show_hidden = true } },
		keys = { { "-", "<cmd>Oil<cr>", "open parent dir" } },
	},
	{
		"saghen/blink.cmp",
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "1.*",
		opts = {
			keymap = { preset = "enter" },
			signature = { enabled = true },
			completion = { documentation = { auto_show = true } },
			fuzzy = { implementation = "prefer_rust_with_warning" },
			sources = { default = { "lsp", "path", "snippets", "buffer" } },
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.install").prefer_git = true
			require("nvim-treesitter.configs").setup({
				auto_install = true,
				highlight = { enable = true, additional_vim_regex_highlighting = false },
				ensure_installed = { "diff", "lua", "luadoc", "markdown", "markdown_inline", "vimdoc" },
			})
		end,
	},
	{
		"ibhagwan/fzf-lua",
		config = function()
			local fzf = require("fzf-lua")
			fzf.setup({ fzf_bin = "sk" })
			map("n", "grr", fzf.lsp_references, {})
			map("n", "gd", fzf.lsp_definitions, {})
			map("n", "gca", fzf.lsp_code_actions, {})
			map("n", "<leader>ff", fzf.files, "find file")
			map("n", "<leader>fb", fzf.buffers, "find buffer")
			map("n", "<leader>fg", fzf.live_grep, "find word")
			map("n", "<leader>fr", fzf.resume, "resume search")
			map("n", "<leader>/", fzf.grep_curbuf, "find word in buffer")
			map("n", "<leader>xx", fzf.diagnostics_document, "diagnostics")
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {
			format_on_save = { lsp_format = true, async = false, stop_after_first = true },
			formatters_by_ft = {
				css = { "prettier" },
				go = { "goimports", "golines", "gofumpt", stop_after_first = false },
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
			"neovim/nvim-lspconfig",
			"zapling/mason-conform.nvim",
			"mason-org/mason-lspconfig.nvim",
		},
		config = function()
			local servers = { "cssls", "html", "lua_ls", "gopls", "ts_ls" }
			local capabilities = require("blink.cmp").get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())
			vim.lsp.config("*", { capabilities = capabilities })
			vim.diagnostic.config({ severity_sort = true, virtual_lines = false, virtual_text = true })
			require("mason").setup()
			require("mason-lspconfig").setup({ ensure_installed = servers, automatic_enable = true })
			require("mason-conform").setup({})
		end,
	},
})
vim.cmd.colorscheme("default")
