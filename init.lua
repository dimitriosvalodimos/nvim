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
opt.scrolloff = 5
opt.shiftround = true
opt.shiftwidth = 2
opt.shortmess = "c"
opt.sidescrolloff = 5
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
local servers = {
	cssls = {},
	html = {},
	lua_ls = {
		settings = {
			Lua = {
				completion = { callSnippet = "Replace" },
				diagnostics = { globals = { "vim" } },
				runtime = { version = "LuaJIT" },
				telemetry = { enable = false },
				workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
			},
		},
	},
	ts_ls = {},
}
local diagnostic_config = { severity_sort = true, virtual_lines = false, virtual_text = true }
map("v", "<", "<gv", "dedent")
map("v", ">", ">gv", "indent")
map("i", "<A-u>", "<c-r>=trim(system('uuidgen'))<cr>", "uuid")
map("n", "<A-u>", "i<c-r>=trim(system('uuidgen'))<cr><esc>", "uuid")
map("n", "<leader>k", function()
	vim.diagnostic.config({ virtual_lines = { current_line = true }, virtual_text = false })
	vim.api.nvim_create_autocmd("CursorMoved", {
		group = vim.api.nvim_create_augroup("line-diagnostics", { clear = true }),
		callback = function()
			vim.diagnostic.config(diagnostic_config)
			return true
		end,
	})
end)
require("lazy").setup({
	{
		"lewis6991/gitsigns.nvim",
		lazy = false,
		opts = {},
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
			{ "<leader>fr", ":silent FzfLua resume<cr>", desc = "resume search" },
			{ "<leader>fb", ":silent FzfLua buffers<cr>", desc = "find buffer" },
			{ "<leader>fg", ":silent FzfLua live_grep<cr>", desc = "find word" },
		},
	},
	{
		"williamboman/mason.nvim",
		dependencies = { "neovim/nvim-lspconfig", "saghen/blink.cmp" },
		config = function()
			local lspconfig = require("lspconfig")
			require("mason").setup()
			local capabilities = require("blink.cmp").get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())
			vim.diagnostic.config(diagnostic_config)
			for server, config in pairs(servers) do
				lspconfig[server].setup({ capabilities = capabilities, settings = config.settings or {} })
			end
		end,
	},
	{ "xemptuous/sqlua.nvim", lazy = true, cmd = "SQLua", opts = {} },
	{ "kevinhwang91/nvim-bqf", ft = "qf", dependencies = { "nvim-treesitter/nvim-treesitter" } },
	{
		"stevearc/conform.nvim",
		opts = {
			format_on_save = { lsp_format = true, async = false, stop_after_first = true },
			formatters_by_ft = {
				css = { "biome-check", "prettier" },
				html = { "biome-check", "prettier" },
				javascript = { "biome-check", "prettier" },
				javascriptreact = { "biome-check", "prettier" },
				json = { "biome-check", "prettier" },
				lua = { "stylua" },
				typescript = { "biome-check", "prettier" },
				typescriptreact = { "biome-check", "prettier" },
			},
		},
	},
})
vim.cmd.colorscheme("default") -- default, lunaperche, retrobox, slate, sorbet
-- MasonInstall css-lsp html-lsp typescript-language-server lua-language-server stylua prettier
