local g = vim.g
local opt = vim.opt
g.mapleader = " "
g.maplocalleader = ","
opt.backupcopy = "yes"
opt.background = "dark"
opt.breakindent = true
opt.clipboard = "unnamedplus"
opt.completeopt = { "menu", "menuone", "noselect", "popup" }
opt.conceallevel = 0 -- don't hide bold/italic markers
opt.confirm = true -- ask to save changes
opt.copyindent = true
opt.cursorline = true
opt.diffopt = vim.list_extend(vim.opt.diffopt:get(), { "algorithm:histogram", "linematch:60" })
opt.expandtab = true
opt.foldcolumn = "1"
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99 -- start with all code unfolded
opt.hlsearch = true
opt.ignorecase = true -- case insensitive searching
opt.inccommand = "nosplit" -- preview substitute
opt.infercase = true -- infer cases in keyword completion
opt.laststatus = 3 -- global statusline
opt.number = true
opt.numberwidth = 4
opt.preserveindent = true
opt.pumblend = 10 -- popup blend
opt.pumheight = 10 -- popup max height
opt.relativenumber = true
opt.scrolloff = 5 -- vertical buffer area on scroll
opt.shiftround = true
opt.shiftwidth = 2
-- opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.sidescrolloff = 5 -- horizontal buffer area on scroll
opt.signcolumn = "yes" -- Always show the signcolumn
opt.smartcase = true
opt.smartindent = true
opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true
opt.tabstop = 2
opt.termguicolors = true
opt.updatetime = 300
opt.timeoutlen = 300
opt.timeout = true
opt.title = true
opt.undofile = true
opt.undolevels = 10000
opt.virtualedit = "block"
opt.wildmode = { "longest:full", "full" }
opt.wrap = false

if vim.fn.has("nvim-0.10") == 1 then
	opt.smoothscroll = true
	opt.foldmethod = "expr"
	opt.foldtext = ""
end
local disabled_plugins = {
	"2html_plugin",
	"tohtml",
	"getscript",
	"getscriptPlugin",
	"gzip",
	"logipat",
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"matchit",
	"tar",
	"tarPlugin",
	"rrhelper",
	"spellfile_plugin",
	"vimball",
	"vimballPlugin",
	"zip",
	"zipPlugin",
	"tutor",
	"rplugin",
	"syntax",
	"synmenu",
	"optwin",
	"compiler",
	"bugreport",
	"ftplugin",
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
vim.keymap.set("i", "<c-u>", "<c-r>=trim(system('uuidgen'))<cr>", { desc = "insert uuid at cursor" })
vim.keymap.set("n", "<c-u>", "i<c-r>=trim(system('uuidgen'))<cr><esc>", { desc = "insert uuid at cursor" })
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "move line up" })
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "move line down" })
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "move line up" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "move line down" })
vim.keymap.set("v", "<", "<gv", { desc = "dedent" })
vim.keymap.set("v", ">", ">gv", { desc = "indent" })

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
	spec = {
		{ "nvim-tree/nvim-web-devicons", opts = {} },
		{ "nyoom-engineering/oxocarbon.nvim", lazy = true, priority = 1000 },
		{
			"olivercederborg/poimandres.nvim",
			lazy = true,
			priority = 1000,
			opts = {
				bold_vert_split = true,
				dim_nc_background = true,
				disable_background = false,
				disable_float_background = false,
				disable_italics = false,
			},
		},
		{ "kvrohit/substrata.nvim", lazy = true, priority = 1000 },
		{
			"datsfilipe/vesper.nvim",
			lazy = true,
			priority = 1000,
			opts = {
				transparent = false,
				italics = {
					comments = true,
					keywords = false,
					functions = false,
					strings = false,
					variables = false,
				},
			},
		},
		{
			"no-clown-fiesta/no-clown-fiesta.nvim",
			lazy = true,
			priority = 1000,
			opts = {
				transparent = false,
				styles = {
					comments = { italic = true },
					functions = { bold = true },
					keywords = { bold = true },
					lsp = { underline = true },
					match_paren = {},
					type = { bold = true, italic = true },
					variables = {},
				},
			},
		},
		{ "cocopon/iceberg.vim", lazy = true, priority = 1000 },
		{
			"nvim-lualine/lualine.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			opts = {
				options = { section_separators = "", component_separators = "" },
			},
		},
		{
			"stevearc/oil.nvim",
			opts = {},
			dependencies = { "nvim-tree/nvim-web-devicons" },
			keys = { { "-", "<cmd>Oil<cr>", desc = "open parent dir" } },
		},
		{
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
			dependencies = {
				"andymass/vim-matchup",
				"windwp/nvim-ts-autotag",
			},
			config = function()
				require("nvim-treesitter.install").prefer_git = true
				require("nvim-treesitter.configs").setup({
					ensure_installed = {
						"bash",
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
						"svelte",
						"tsx",
						"typescript",
						"vim",
						"vimdoc",
					},
					auto_install = true,
					matchup = { enable = true },
					highlight = { enable = true },
				})
				require("nvim-ts-autotag").setup({
					opts = {
						enable_close = true,
						enable_rename = true,
						enable_close_on_slash = true,
					},
				})
			end,
		},
		{
			"nvim-telescope/telescope.nvim",
			event = "VimEnter",
			tag = "0.1.8",
			dependencies = {
				"nvim-lua/plenary.nvim",
				{
					"nvim-telescope/telescope-fzf-native.nvim",
					build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
				},
			},
			config = function()
				local telescope = require("telescope")
				telescope.setup({
					extensions = {
						fzf = {
							fuzzy = true,
							override_generic_sorter = true,
							override_file_sorter = true,
							case_mode = "smart_case", -- ignore_case, respect_case
						},
					},
				})
				telescope.load_extension("fzf")
				local builtin = require("telescope.builtin")
				vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "find help" })
				vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "find buffer" })
				vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "find keymapping" })
				vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "find file" })
				vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "find current word" })
				vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "live grep" })
				vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "find diagnostics" })
				vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "resume search" })
				vim.keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = 'find recent files ("." for repeat)' })
				vim.keymap.set("n", "<leader>/", function()
					builtin.current_buffer_fuzzy_find(
						require("telescope.themes").get_dropdown({ winblend = 10, previewer = false })
					)
				end, { desc = "fuzzy find in buffer" })
				vim.keymap.set("n", "<leader>f/", function()
					builtin.live_grep({
						grep_open_files = true,
						prompt_title = "Live Grep in Open Files",
					})
				end, { desc = "find in open files" })
			end,
		},
		{
			"echasnovski/mini.nvim",
			config = function()
				require("mini.pairs").setup()
				require("mini.tabline").setup()
				require("mini.completion").setup()
			end,
		},
		{
			"williamboman/mason.nvim",
			dependencies = {
				"williamboman/mason-lspconfig.nvim",
				"neovim/nvim-lspconfig",
				{
					"j-hui/fidget.nvim",
					opts = { progress = { ignore_done_already = false, ignore_empty_message = false } },
				},
			},
			config = function()
				local servers = {
					biome = {
						filetypes = {
							"javascript",
							"javascriptreact",
							"json",
							"typescript",
							"typescript.tsx",
							"typescriptreact",
							"css",
						},
						settings = {},
					},
					cssls = { filetypes = { "css" }, settings = {} },
					css_variables = { filetypes = { "css" }, settings = {} },
					emmet_ls = {
						filetypes = { "css", "html", "javascriptreact", "svelte", "typescriptreact" },
						settings = {},
					},
					eslint = {
						filetypes = {
							"javascript",
							"javascriptreact",
							"javascript.jsx",
							"typescript",
							"typescriptreact",
							"typescript.tsx",
							"svelte",
						},
						settings = {},
					},
					gopls = { filetypes = { "go", "gomod", "gowork", "gotmpl" }, settings = {} },
					html = { filetypes = { "html", "templ" }, settings = {} },
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
					tsserver = {
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
				}
				local capabilities = vim.lsp.protocol.make_client_capabilities()
				capabilities.textDocument.completion.completionItem.snippetSupport = true

				local lspconfig = require("lspconfig")
				local float_config = {
					header = "",
					border = "single",
					source = "if_many",
					severity_sort = true,
				}
				vim.api.nvim_create_autocmd("LspAttach", {
					group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
					callback = function(event)
						local map = function(keys, func, desc)
							vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
						end
						map("gd", require("telescope.builtin").lsp_definitions, "goto definition")
						map("gr", require("telescope.builtin").lsp_references, "goto references")
						map("gI", require("telescope.builtin").lsp_implementations, "goto implementation")
						map("<leader>D", require("telescope.builtin").lsp_type_definitions, "goto type definition")
						map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "document symbols")
						map(
							"<leader>ws",
							require("telescope.builtin").lsp_dynamic_workspace_symbols,
							"workspace symbols"
						)
						map("<leader>rn", vim.lsp.buf.rename, "rename")
						map("<leader>ca", vim.lsp.buf.code_action, "code action")
						map("gD", vim.lsp.buf.declaration, "goto declaration")
						local client = vim.lsp.get_client_by_id(event.data.client_id)
						if
							client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight)
						then
							local highlight_augroup =
								vim.api.nvim_create_augroup("config-lsp-highlight", { clear = false })
							vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
								buffer = event.buf,
								group = highlight_augroup,
								callback = function()
									vim.lsp.buf.document_highlight()
									local config = float_config
									config = vim.tbl_deep_extend("force", config, {
										focusable = false,
										close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
										scope = "cursor",
									})
									vim.diagnostic.open_float(nil, config)
								end,
							})
							vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
								buffer = event.buf,
								group = highlight_augroup,
								callback = vim.lsp.buf.clear_references,
							})
							vim.api.nvim_create_autocmd("LspDetach", {
								group = vim.api.nvim_create_augroup("config-lsp-detach", { clear = true }),
								callback = function(event2)
									vim.lsp.buf.clear_references()
									vim.api.nvim_clear_autocmds({ group = "config-lsp-highlight", buffer = event2.buf })
								end,
							})
						end
						if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
							map("<leader>th", function()
								vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
							end, "toggle inlay hints")
						end
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
							settings = config.settings or {},
						})
					end,
				})

				vim.diagnostic.config({
					virtual_text = {
						source = "if_many",
						linehl = { "DiagnosticErrorLn", "DiagnosticWarnLn", "DiagnosticInfoLn", "DiagnosticHintLn" },
					},
					signs = {
						linehl = { "DiagnosticErrorLn", "DiagnosticWarnLn", "DiagnosticInfoLn", "DiagnosticHintLn" },
					},
					underline = true,
					update_in_insert = false,
					severity_sort = true,
					float = float_config,
				})
			end,
		},
		{
			"folke/trouble.nvim",
			opts = {},
			cmd = "Trouble",
			keys = {
				{ "<leader>XX", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
				{
					"<leader>xx",
					"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
					desc = "Buffer Diagnostics (Trouble)",
				},
				{ "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
			},
		},
		{
			"folke/which-key.nvim",
			event = "VeryLazy",
			opts = {},
		},
		{
			"NeogitOrg/neogit",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"sindrets/diffview.nvim",
				"nvim-telescope/telescope.nvim",
				{ "akinsho/git-conflict.nvim", version = "*", config = true },
				{
					"lewis6991/gitsigns.nvim",
					opts = {
						signs = {
							add = { text = "+" },
							change = { text = "~" },
							delete = { text = "_" },
							topdelete = { text = "‾" },
							changedelete = { text = "~" },
						},
					},
					keys = { { "<leader>gs", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "toggle blame" } },
				},
			},
			opts = {},
		},
		{
			"folke/todo-comments.nvim",
			dependencies = { "nvim-lua/plenary.nvim" },
			opts = { signs = false },
		},
		{
			"stevearc/conform.nvim",
			opts = {
				notify_on_error = false,
				format_on_save = {
					timeout_ms = 500,
					lsp_format = "fallback",
				},
				formatters_by_ft = {
					css = { "prettier", "biome", stop_after_first = true },
					go = { "goimports", "golines", "gofumpt" },
					html = { "prettier", "biome", stop_after_first = true },
					javascript = { "prettier", "biome", stop_after_first = true },
					javascriptreact = { "prettier", "biome", stop_after_first = true },
					json = { "prettier", "biome", stop_after_first = true },
					lua = { "stylua" },
					typescript = { "prettier", "biome", stop_after_first = true },
					typescriptreact = { "prettier", "biome", stop_after_first = true },
				},
			},
		},
		{
			"kevinhwang91/nvim-hlslens",
			opts = { calm_down = true, nearest_only = true, nearest_float_when = "always" },
		},
	},
})

-- poimandres, substrata, iceberg, oh-lucy, oh-lucy-evening, vesper, no-clown-fiesta, aura, oxocarbon
vim.cmd.colorscheme("oxocarbon")
