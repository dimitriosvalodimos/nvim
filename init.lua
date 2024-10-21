local g = vim.g
local opt = vim.opt

g.mapleader = " "
g.maplocalleader = ","

opt.background = "dark"
opt.backupcopy = "yes"
opt.breakindent = true
opt.clipboard = "unnamedplus"
opt.completeopt = { "menu", "menuone", "noselect", "noinsert", "popup" }
opt.conceallevel = 0
opt.confirm = true
opt.copyindent = true
opt.cursorline = true
opt.cursorlineopt = "number"
opt.diffopt = vim.list_extend(vim.opt.diffopt:get(), { "algorithm:histogram", "linematch:60" })
opt.expandtab = true
opt.foldcolumn = "1"
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.hlsearch = true
opt.ignorecase = true
opt.inccommand = "nosplit"
opt.infercase = true
opt.laststatus = 3
opt.number = true
opt.numberwidth = 4
opt.preserveindent = true
opt.pumblend = 0
opt.pumheight = 10
opt.scrolloff = 5
opt.shiftround = true
opt.shiftwidth = 2
opt.sidescrolloff = 5
opt.signcolumn = "yes"
opt.smartcase = true
opt.smartindent = true
opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true
opt.tabstop = 2
opt.termguicolors = true
opt.timeoutlen = 300
opt.timeout = true
opt.title = true
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 300
opt.virtualedit = "block"
opt.wildmode = { "longest:full", "full" }
opt.winblend = 0
opt.wrap = false

if vim.fn.has("nvim-0.10") == 1 then
	opt.smoothscroll = true
	opt.foldmethod = "expr"
	opt.foldtext = ""
end

local disabled_plugins = {
	"2html_plugin",
	"bugreport",
	"compiler",
	"ftplugin",
	"getscript",
	"getscriptPlugin",
	"gzip",
	"logipat",
	"matchit",
	"netrw",
	"netrwFileHandlers",
	"netrwPlugin",
	"netrwSettings",
	"optwin",
	"rplugin",
	"rrhelper",
	"spellfile_plugin",
	"synmenu",
	"syntax",
	"tar",
	"tarPlugin",
	"tohtml",
	"tutor",
	"vimball",
	"vimballPlugin",
	"zip",
	"zipPlugin",
}

for i = 1, #disabled_plugins do
	g["loaded_" .. disabled_plugins[i]] = true
end

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
	{ "nyoom-engineering/oxocarbon.nvim", lazy = true, priority = 1000 },
	{ "aktersnurra/no-clown-fiesta.nvim", lazy = true, priority = 1000, opts = {} },
	{ "Mofiqul/vscode.nvim", lazy = true, priority = 1000, opts = { transparent = false, italic_comments = false } },
	{
		"olivercederborg/poimandres.nvim",
		lazy = true,
		priority = 1000,
		opts = {
			bold_vert_split = false,
			dim_nc_background = false,
			disable_background = false,
			disable_float_background = false,
			disable_italics = true,
		},
	},
	{
		"blazkowolf/gruber-darker.nvim",
		lazy = true,
		priority = 1000,
		opts = {
			bold = true,
			invert = {
				signs = false,
				tabline = false,
				visual = false,
			},
			italic = {
				strings = false,
				comments = false,
				operators = false,
				folds = false,
			},
			undercurl = true,
			underline = true,
		},
	},
	{
		"scottmckendry/cyberdream.nvim",
		lazy = true,
		priority = 1000,
		opts = {
			transparent = false,
			italic_comments = false,
			hide_fillchars = false,
			borderless_telescope = true,
			terminal_colors = true,
			cache = false,
			theme = { variant = "default" },
			extensions = {
				cmp = true,
				gitsigns = true,
				grugfar = true,
				lazy = true,
				markdown = true,
				notify = true,
				telescope = true,
				treesitter = true,
				whichkey = true,
			},
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({})
			map("n", "<leader>gs", "<cmd>Gitsigns toggle_current_line_blame<cr>", { desc = "toggle git blame" })
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = { theme = "auto" },
			tabline = { lualine_a = { "buffers" }, lualine_z = { "tabs" } },
		},
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		dependencies = { { "Bilal2453/luvit-meta", lazy = true } },
		opts = { library = { { path = "luvit-meta/library", words = { "vim%.uv" } } } },
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						vim.snippet.expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete({}),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "lazydev", group_index = 0 },
					{ name = "buffer" },
				}),
			})
			cmp.setup.cmdline(":", {
				view = {
					entries = { name = "wildmenu", separator = " | " },
				},
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
					{ name = "cmdline" },
				}),
				matching = { disallow_symbol_nonprefix_matching = false },
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
					"html",
					"http",
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
			"rachartier/tiny-inline-diagnostic.nvim",
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
			"nvim-lua/plenary.nvim",
			"hrsh7th/cmp-nvim-lsp",
			{
				"j-hui/fidget.nvim",
				opts = {
					progress = { ignore_done_already = true, ignore_empty_message = true },
					notification = { window = { winblend = 0 } },
				},
			},
		},
		config = function()
			local servers = {
				biome = {
					filetypes = {
						"javascript",
						"javascriptreact",
						"json",
						"jsonc",
						"typescript",
						"typescript.tsx",
						"typescriptreact",
						"css",
					},
				},
				cssls = { filetypes = { "css" }, settings = {} },
				eslint = {
					filetypes = {
						"javascript",
						"javascriptreact",
						"javascript.jsx",
						"typescript",
						"typescriptreact",
						"typescript.tsx",
					},
					settings = {},
				},
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
				tinymist = {
					settings = {
						exportPdf = "onType",
						preview = {
							refresh = "onType",
							invertColors = "always",
							cursorIndicator = true,
							showExportFileIn = "Orion.app",
						},
					},
					filetypes = { "typst" },
				},
				typst_lsp = {
					settings = { exportPdf = "onType" }, -- onSave
					filetypes = { "typst" },
				},
			}
			local capabilities = vim.tbl_deep_extend(
				"force",
				vim.lsp.protocol.make_client_capabilities(),
				require("cmp_nvim_lsp").default_capabilities(),
				{
					textDocument = {
						completion = {
							completionItem = {
								documentationFormat = { "markdown", "plaintext" },
								snippetSupport = true,
								preselectSupport = true,
								insertReplaceSupport = true,
								labelDetailsSupport = true,
								deprecatedSupport = true,
								commitCharactersSupport = true,
								tagSupport = { valueSet = { 1 } },
								resolveSupport = { properties = { "documentation", "detail", "additionalTextEdits" } },
							},
						},
					},
				}
			)
			local lspconfig = require("lspconfig")
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("config-lsp-attach", { clear = true }),
				callback = function(event)
					local buffer = event.buf
					local builtin = require("telescope.builtin")
					map("n", "K", vim.lsp.buf.hover, { buffer = buffer, desc = "hover" })
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
					map(
						{ "v", "n" },
						"<leader>ca",
						vim.lsp.buf.code_action,
						{ buffer = buffer, desc = "LSP: code action" }
					)
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
			require("tiny-inline-diagnostic").setup({})
			vim.diagnostic.config({ virtual_text = false })
		end,
	},
	{ "stevearc/oil.nvim", opts = {}, keys = { { "-", "<cmd>Oil<cr>", desc = "open parent dir" } } },
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
				css = { "biome-check", "biome", "prettier", stop_after_first = true },
				go = { "goimports", "golines", "gofumpt" },
				html = { "prettier", "biome-check", "biome", stop_after_first = true },
				javascript = { "biome-check", "biome", "prettier", stop_after_first = true },
				javascriptreact = { "biome-check", "biome", "prettier", stop_after_first = true },
				json = { "biome-check", "biome", "prettier", stop_after_first = true },
				lua = { "stylua" },
				typescript = { "biome-check", "biome", "prettier", stop_after_first = true },
				typescriptreact = { "biome-check", "biome", "prettier", stop_after_first = true },
			},
		},
	},
	{ "MagicDuck/grug-far.nvim", opts = {}, keys = { { ",", "<cmd>GrugFar<cr>", desc = "Search/Replace" } } },
	{
		"chomosuke/typst-preview.nvim",
		ft = "typst",
		cmd = {
			"TypstPreviewUpdate",
			"TypstPreview",
			"TypstPreviewStop",
			"TypstPreviewToggle",
			"TypstPreviewFollowCursor",
			"TypstPreviewNoFollowCursor",
			"TypstPreviewFollowCursorToggle",
		},
		version = "1.*",
		build = function()
			require("typst-preview").update()
		end,
	},
})
-- gruber-darker, no-clown-fiesta, oxocarbon, vscode, poimandres, cyberdream
vim.cmd.colorscheme("gruber-darker")
