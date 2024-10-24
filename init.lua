local g = vim.g
local opt = vim.opt
g.mapleader = " "
g.maplocalleader = ","
opt.breakindent = true
opt.clipboard = "unnamedplus"
opt.confirm = true
opt.copyindent = true
opt.cursorline = true
opt.cursorlineopt = "number"
opt.diffopt = vim.list_extend(vim.opt.diffopt:get(), { "algorithm:histogram", "linematch:60" })
opt.expandtab = true
opt.ignorecase = true
opt.infercase = true
opt.laststatus = 3
opt.number = true
opt.numberwidth = 4
opt.preserveindent = true
opt.pumheight = 10
opt.scrolloff = 5
opt.shiftround = true
opt.shiftwidth = 2
opt.sidescrolloff = 5
opt.signcolumn = "yes"
opt.smartcase = true
opt.smartindent = true
opt.termguicolors = true
opt.tabstop = 2
opt.virtualedit = "block"
opt.wrap = false
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", {}),
	desc = "Highlight selection on yank",
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
	end,
})
local function map(mode, lhs, rhs, opts)
	vim.keymap.set(mode, lhs, rhs, opts or {})
end
map("n", "<c-h>", "<c-w><c-h>", { desc = "Move focus to the left window" })
map("n", "<c-l>", "<c-w><c-l>", { desc = "Move focus to the right window" })
map("n", "<c-j>", "<c-w><c-j>", { desc = "Move focus to the lower window" })
map("n", "<c-k>", "<c-w><c-k>", { desc = "Move focus to the upper window" })
map("i", "<c-u>", "<c-r>=trim(system('uuidgen'))<cr>", { desc = "insert uuid at cursor" })
map("n", "<c-u>", "i<c-r>=trim(system('uuidgen'))<cr><esc>", { desc = "insert uuid at cursor" })
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "move line up" })
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "move line down" })
map("n", "<A-j>", ":m .+1<CR>==", { desc = "move line up" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "move line down" })
map("v", "<", "<gv", { desc = "dedent" })
map("v", ">", ">gv", { desc = "indent" })

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

require("lazy").setup({
	{ "nvim-tree/nvim-web-devicons", opts = {} },
	{ "aktersnurra/no-clown-fiesta.nvim", lazy = true, priority = 1000, opts = {} },
	{ "mrjones2014/lighthaus.nvim", lazy = true, priority = 1000, opts = {} },
	{
		"blazkowolf/gruber-darker.nvim",
		lazy = true,
		priority = 1000,
		opts = { italic = { strings = false, comments = false, operators = false, folds = false } },
	},
	{
		"killitar/obscure.nvim",
		lazy = true,
		priority = 1000,
		opts = {
			styles = {
				keywords = { italic = false, bold = true },
				functions = { bold = true },
				booleans = { bold = true },
				comments = { italic = false },
			},
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {},
		event = "BufEnter",
		keys = { { "<leader>gs", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "toggle git blame" } },
	},
	{
		"nvim-lualine/lualine.nvim",
		opts = { options = { theme = "auto" }, tabline = { lualine_a = { "buffers" }, lualine_z = { "tabs" } } },
	},
	{
		"iguanacucumber/magazine.nvim",
		name = "nvim-cmp",
		dependencies = {
			"https://codeberg.org/FelipeLema/cmp-async-path",
			{ "iguanacucumber/mag-buffer", name = "cmp-buffer" },
			{ "iguanacucumber/mag-cmdline", name = "cmp-cmdline" },
			{ "iguanacucumber/mag-nvim-lsp", name = "cmp-nvim-lsp", opts = {} },
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete({}),
				}),
				sources = cmp.config.sources({ { name = "nvim_lsp" }, { name = "buffer" } }),
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = { "andymass/vim-matchup" },
		config = function()
			require("nvim-treesitter.install").prefer_git = true
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"css",
					"diff",
					"go",
					"gomod",
					"gosum",
					"html",
					"javascript",
					"jsdoc",
					"json",
					"lua",
					"luadoc",
					"markdown",
					"markdown_inline",
					"regex",
					"sql",
					"tsx",
					"typescript",
				},
				auto_install = true,
				matchup = { enable = true },
				highlight = { enable = true, additional_vim_regex_highlighting = false },
			})
		end,
	},
	{ "numToStr/Comment.nvim", opts = {} },
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
			},
		},
		tag = "0.1.8",
		config = function()
			local telescope = require("telescope")
			telescope.setup({
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "ignore_case",
					},
				},
				defaults = require("telescope.themes").get_ivy({
					previewer = false,
					layout_config = { prompt_position = "bottom" },
				}),
				pickers = {
					current_buffer_fuzzy_find = { previewer = true },
					live_grep = { previewer = true },
				},
			})
			telescope.load_extension("fzf")
		end,
		keys = {
			{ "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", desc = "find help tags" },
			{ "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", desc = "find buffers" },
			{ "<leader>fk", "<cmd>lua require('telescope.builtin').keymaps()<cr>", desc = "find keymaps" },
			{ "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", desc = "find files" },
			{ "<leader>fw", "<cmd>lua require('telescope.builtin').grep_string()<cr>", desc = "find string" },
			{ "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", desc = "find live" },
			{ "<leader>fd", "<cmd>lua require('telescope.builtin').diagnostics()<cr>", desc = "find diagnostics" },
			{ "<leader>fr", "<cmd>lua require('telescope.builtin').resume()<cr>", desc = "resume search" },
			{ "<leader>fR", "<cmd>lua require('telescope.builtin').registers()<cr>", desc = "registers" },
			{ "<leader>f.", "<cmd>lua require('telescope.builtin').oldfiles()<cr>", desc = "find in oldfiles" },
			{ "<leader>xx", "<cmd>lua require('telescope.builtin').diagnostics()<cr>", desc = "diagnostics" },
			{
				"<leader>/",
				"<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>",
				desc = "find in file",
			},
			{
				"<leader>f/",
				"<cmd>lua require('telescope.builtin').live_grep({ grep_open_files = true })<cr>",
				desc = "find in open files",
			},
		},
	},
	{
		"williamboman/mason.nvim",
		dependencies = {
			{ "iguanacucumber/mag-nvim-lsp", name = "cmp-nvim-lsp", opts = {} },
			"williamboman/mason-lspconfig.nvim",
			"nvim-telescope/telescope.nvim",
			"neovim/nvim-lspconfig",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local servers = {
				cssls = { filetypes = { "css" }, settings = {} },
				gopls = { filetypes = { "go", "gomod", "gowork", "gotmpl" }, settings = {} },
				html = { filetypes = { "html" }, settings = {} },
				lua_ls = {
					filetypes = { "lua" },
					settings = {
						Lua = {
							completion = { callSnippet = "Replace" },
							diagnostics = { globals = { "vim" }, disable = { "missing-fields" } },
							runtime = { version = "LuaJIT" },
							telemetry = { enable = false },
							workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
						},
					},
				},
				ts_ls = {
					filetypes = {
						"javascript",
						"javascriptreact",
						"javascript.jsx",
						"typescript",
						"typescriptreact",
						"typescript.tsx",
					},
					settings = {
						typescript = {},
						javascript = {},
					},
				},
			}
			local capabilities = vim.tbl_deep_extend(
				"force",
				vim.lsp.protocol.make_client_capabilities(),
				require("cmp_nvim_lsp").default_capabilities()
			)
			local lspconfig = require("lspconfig")
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("config-lsp-attach", { clear = true }),
				callback = function(event)
					local buffer = event.buf
					local builtin = require("telescope.builtin")
					map("n", "gd", builtin.lsp_definitions, { buffer = buffer, desc = "goto definition" })
					map("n", "gr", builtin.lsp_references, { buffer = buffer, desc = "goto references" })
					map("n", "gI", builtin.lsp_implementations, { buffer = buffer, desc = "goto implementation" })
					map(
						"n",
						"<leader>gD",
						builtin.lsp_type_definitions,
						{ buffer = buffer, desc = "goto type definition" }
					)
					map("n", "gD", vim.lsp.buf.declaration, { buffer = buffer, desc = "goto declaration" })
					map("n", "<leader>rn", vim.lsp.buf.rename, { buffer = buffer, desc = "rename" })
					map("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = buffer, desc = "LSP: code action" })
					map("n", "<leader>k", vim.diagnostic.open_float, { buffer = buffer, desc = "open float" })
				end,
			})
			require("mason").setup()
			local mason_lspconfig = require("mason-lspconfig")
			mason_lspconfig.setup({ ensure_installed = vim.tbl_keys(servers) })
			mason_lspconfig.setup_handlers({
				function(server_name)
					local config = servers[server_name] or {}
					lspconfig[server_name].setup({
						capabilities = capabilities,
						filetypes = config.filetypes or {},
						flags = { debounce_text_changes = 150 },
						settings = config.settings or {},
					})
				end,
			})
		end,
	},
	{ "stevearc/oil.nvim", opts = {}, keys = { { "-", "<cmd>Oil<cr>", desc = "open parent dir" } } },
	{ "MagicDuck/grug-far.nvim", opts = {}, keys = { { ",", "<cmd>GrugFar<cr>", desc = "Search/Replace" } } },
	{
		"stevearc/conform.nvim",
		event = "VeryLazy",
		opts = {
			notify_on_error = false,
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
			formatters_by_ft = {
				css = { "prettier" },
				go = { "goimports", "golines", "gofumpt" },
				html = { "prettier" },
				javascript = { "biome-check", "biome", "prettier", stop_after_first = true },
				javascriptreact = { "biome-check", "biome", "prettier", stop_after_first = true },
				json = { "biome-check", "biome", "prettier", stop_after_first = true },
				lua = { "stylua" },
				typescript = { "biome-check", "biome", "prettier", stop_after_first = true },
				typescriptreact = { "biome-check", "biome", "prettier", stop_after_first = true },
			},
		},
	},
})
-- gruber-darker, no-clown-fiesta, obscure, lighthaus
vim.cmd.colorscheme("lighthaus")
