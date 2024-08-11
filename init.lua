local g = vim.g
local opt = vim.opt

g.mapleader = " "
g.maplocalleader = ","

opt.backupcopy = "yes"
opt.background = "dark"
opt.breakindent = true
opt.clipboard = "unnamedplus"
opt.completeopt = { "menu", "menuone", "noselect" }
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
		{
			"folke/tokyonight.nvim",
			lazy = true,
			priority = 1000,
			opts = {
				styles = {
					comments = {},
					keywords = { bold = true },
					functions = { bold = true },
					variables = {},
					sidebars = "dark",
					floats = "dark",
				},
			},
		},
		{
			"rose-pine/neovim",
			lazy = true,
			priority = 1000,
			name = "rose-pine",
			opts = {
				dim_inactive_windows = false,
				extend_background_behind_borders = true,
				enable = {
					terminal = true,
					legacy_highlights = true,
					migrations = true,
				},
				highlight_groups = {
					TelescopeBorder = { fg = "overlay", bg = "overlay" },
					TelescopeNormal = { fg = "subtle", bg = "overlay" },
					TelescopeSelection = { fg = "text", bg = "highlight_med" },
					TelescopeSelectionCaret = { fg = "love", bg = "highlight_med" },
					TelescopeMultiSelection = { fg = "text", bg = "highlight_high" },
					TelescopeTitle = { fg = "base", bg = "love" },
					TelescopePromptTitle = { fg = "base", bg = "pine" },
					TelescopePreviewTitle = { fg = "base", bg = "iris" },
					TelescopePromptNormal = { fg = "text", bg = "surface" },
					TelescopePromptBorder = { fg = "surface", bg = "surface" },
				},
				styles = {
					bold = true,
					italic = false,
					transparency = false,
				},
			},
		},
		{
			"projekt0n/github-nvim-theme",
			lazy = true,
			priority = 1000,
			name = "github-theme",
			opts = {
				options = {
					compile_path = vim.fn.stdpath("cache") .. "/github-theme",
					compile_file_suffix = "_compiled",
					hide_end_of_buffer = true,
					hide_nc_statusline = true,
					transparent = false,
					terminal_colors = true,
					dim_inactive = false,
					module_default = true,
					styles = {
						comments = "NONE",
						functions = "bold",
						keywords = "bold",
						variables = "NONE",
						conditionals = "NONE",
						constants = "NONE",
						numbers = "NONE",
						operators = "NONE",
						strings = "NONE",
						types = "NONE",
					},
					inverse = {
						match_paren = true,
						visual = true,
						search = true,
					},
					darken = {
						floats = true,
						sidebars = {
							enable = true,
							list = {},
						},
					},
					modules = {},
				},
			},
		},
		{ "nyoom-engineering/oxocarbon.nvim", lazy = true, priority = 1000 },
		{
			"bluz71/vim-moonfly-colors",
			name = "moonfly",
			lazy = true,
			priority = 1000,
			config = function()
				vim.g.moonflyCursorColor = true
				vim.g.moonflyItalics = false
				vim.g.moonflyNormalFloat = true
				vim.g.moonflyTerminalColors = true
				vim.g.moonflyUndercurls = true
				vim.g.moonflyUnderlineMatchParen = true
				vim.g.moonflyVirtualTextColor = true
				vim.g.moonflyWinSeparator = 2
				vim.opt.fillchars = {
					horiz = "━",
					horizup = "┻",
					horizdown = "┳",
					vert = "┃",
					vertleft = "┫",
					vertright = "┣",
					verthoriz = "╋",
				}
			end,
		},
		{
			"dasupradyumna/midnight.nvim",
			lazy = true,
			priority = 1000,
			opts = {},
		},
		{
			"olimorris/onedarkpro.nvim",
			priority = 1000,
			lazy = true,
			opts = {
				styles = {
					types = "NONE",
					methods = "bold",
					numbers = "NONE",
					strings = "NONE",
					comments = "NONE",
					keywords = "bold",
					constants = "NONE",
					functions = "bold",
					operators = "NONE",
					variables = "NONE",
					parameters = "NONE",
					conditionals = "NONE",
					virtual_text = "bold",
				},
				plugins = {
					gitsigns = true,
					nvim_cmp = true,
					nvim_hlslens = true,
					nvim_lsp = true,
					nvim_notify = true,
					nvim_ts_rainbow = true,
					rainbow_delimiters = true,
					telescope = true,
					toggleterm = true,
					treesitter = true,
					trouble = true,
					which_key = true,
				},
				options = {
					cursorline = true,
					transparency = false,
					terminal_colors = true,
					lualine_transparency = false,
					highlight_inactive_windows = false,
				},
			},
		},
		{
			"nvim-lualine/lualine.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			opts = {
				options = { section_separators = "", component_separators = "" },
				sections = {
					lualine_a = { "mode" },
					lualine_b = { { "b:gitsigns_head", icon = "" }, "diff", "diagnostics" },
					lualine_c = {
						"filename",
						{
							"diagnostics",
							sources = { "nvim_lsp", "nvim_diagnostic", "nvim_workspace_diagnostic" },
							sections = { "error", "warn", "info", "hint" },
							diagnostics_color = {
								error = "DiagnosticError",
								warn = "DiagnosticWarn",
								info = "DiagnosticInfo",
								hint = "DiagnosticHint",
							},
							symbols = { error = "E", warn = "W", info = "I", hint = "H" },
							colored = true,
							update_in_insert = true,
							always_visible = false,
						},
					},
					lualine_x = {},
					lualine_y = {},
					lualine_z = { "location" },
				},
				tabline = {
					lualine_a = { "buffers" },
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = { "tabs" },
				},
				extensions = {},
			},
		},
		{ "akinsho/toggleterm.nvim", version = "*", opts = { open_mapping = [[<c-t>]] } },
		{ "windwp/nvim-autopairs", opts = { disable_filetype = { "TelescopePrompt", "vim" } } },
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
				"HiPhish/rainbow-delimiters.nvim",
				"windwp/nvim-ts-autotag",
				"m-demare/hlargs.nvim",
			},
			config = function()
				require("nvim-treesitter.install").prefer_git = true
				require("nvim-treesitter.configs").setup({
					ensure_installed = {
						"bash",
						"c",
						"cpp",
						"css",
						"diff",
						"go",
						"gomod",
						"gosum",
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
						"rust",
						"sql",
						"svelte",
						"tsx",
						"typescript",
						"vim",
						"vimdoc",
						"xml",
						"zig",
					},
					auto_install = true,
					matchup = { enable = true },
					highlight = { enable = true },
				})
				require("hlargs").setup()
				require("rainbow-delimiters.setup").setup({})
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
				"nvim-telescope/telescope-ui-select.nvim",
				{
					"nvim-telescope/telescope-fzf-native.nvim",
					build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
				},
			},
			config = function()
				local telescope = require("telescope")
				telescope.setup({
					extensions = {
						["ui-select"] = { require("telescope.themes").get_dropdown() },
						fzf = {
							fuzzy = true,
							override_generic_sorter = true,
							override_file_sorter = true,
							case_mode = "smart_case", -- ignore_case, respect_case
						},
					},
				})
				telescope.load_extension("fzf")
				telescope.load_extension("ui-select")
				local builtin = require("telescope.builtin")
				vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "find help" })
				vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "find keymapping" })
				vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "find file" })
				vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "find current word" })
				vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "live grep" })
				vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "find diagnostics" })
				vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "resume search" })
				vim.keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = 'find recent files ("." for repeat)' })
				vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "find buffer" })
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
				vim.keymap.set("n", "<leader>fn", function()
					builtin.find_files({ cwd = vim.fn.stdpath("config") })
				end, { desc = "find in neovim files" })
			end,
		},
		{
			"folke/lazydev.nvim",
			ft = "lua",
			dependencies = { "Bilal2453/luvit-meta" },
			opts = {
				library = {
					"lazy.nvim",
					{ path = "luvit-meta/library", words = { "vim%.uv" } },
				},
			},
		},
		{
			"hrsh7th/nvim-cmp",
			dependencies = {
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-cmdline",
				{
					"L3MON4D3/LuaSnip",
					version = "v2.*",
					build = "make install_jsregexp",
					dependencies = {
						{
							"rafamadriz/friendly-snippets",
							config = function()
								require("luasnip.loaders.from_vscode").lazy_load()
							end,
						},
					},
				},
				"saadparwaiz1/cmp_luasnip",
				"onsails/lspkind.nvim",
				"hrsh7th/cmp-nvim-lua",
				"hrsh7th/cmp-nvim-lsp-signature-help",
				"ray-x/cmp-treesitter",
				"ray-x/cmp-sql",
				"folke/lazydev.nvim",
			},
			config = function()
				local cmp = require("cmp")
				local luasnip = require("luasnip")
				luasnip.config.setup({})
				local lspkind = require("lspkind")
				local cmp_autopairs = require("nvim-autopairs.completion.cmp")
				cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
				cmp.setup({
					formatting = { format = lspkind.cmp_format() },
					snippet = {
						expand = function(args)
							luasnip.lsp_expand(args.body)
						end,
					},
					window = {
						completion = cmp.config.window.bordered(),
						documentation = cmp.config.window.bordered(),
					},
					mapping = cmp.mapping.preset.insert({
						["<C-b>"] = cmp.mapping.scroll_docs(-4),
						["<C-f>"] = cmp.mapping.scroll_docs(4),
						["<C-Space>"] = cmp.mapping.complete(),
						["<C-e>"] = cmp.mapping.abort(),
						["<Tab>"] = cmp.mapping(function(fallback)
							if cmp.visible() then
								cmp.select_next_item()
							elseif luasnip.locally_jumpable(1) then
								luasnip.jump(1)
							else
								fallback()
							end
						end, { "i", "s" }),
						["<S-Tab>"] = cmp.mapping(function(fallback)
							if cmp.visible() then
								cmp.select_prev_item()
							elseif luasnip.locally_jumpable(-1) then
								luasnip.jump(-1)
							else
								fallback()
							end
						end, { "i", "s" }),
						["<CR>"] = cmp.mapping(function(fallback)
							if cmp.visible() then
								if luasnip.expandable() then
									luasnip.expand()
								else
									cmp.confirm({
										select = true,
									})
								end
							else
								fallback()
							end
						end),
					}),
					sources = cmp.config.sources({
						{ name = "lazydev", group_index = 0 },
						{ name = "nvim_lsp" },
						{ name = "luasnip" },
						{ name = "nvim_lua" },
						{ name = "treesitter" },
						{ name = "sql" },
						{ name = "nvim_lsp_signature_help" },
					}, {
						{ name = "buffer" },
					}),
				})
				cmp.setup.cmdline("/", {
					view = {
						entries = { name = "wildmenu", separator = "|" },
					},
				})
			end,
		},
		{
			"williamboman/mason.nvim",
			dependencies = {
				"williamboman/mason-lspconfig.nvim",
				"neovim/nvim-lspconfig",
				"hrsh7th/cmp-nvim-lsp",
				"nvim-lua/plenary.nvim",
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
							"svelte",
							"css",
						},
						settings = {},
					},
					cssls = { filetypes = { "css" }, settings = {} },
					cssmodules_ls = {
						filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
						settings = {},
					},
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
					svelte = { filetypes = { "svelte" }, settings = {} },
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
					zls = { filetypes = { "zig", "zir" }, settings = {} },
				}
				local capabilities = vim.lsp.protocol.make_client_capabilities()
				capabilities.textDocument.completion.completionItem.snippetSupport = true
				capabilities =
					vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
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
			"ray-x/go.nvim",
			dependencies = {
				"ray-x/guihua.lua",
				"neovim/nvim-lspconfig",
				"nvim-treesitter/nvim-treesitter",
			},
			opts = {},
			ft = { "go", "gomod" },
			build = ':lua require("go.install").update_all_sync()',
		},
		{
			"folke/trouble.nvim",
			opts = {},
			cmd = "Trouble",
			keys = {
				{
					"<leader>xx",
					"<cmd>Trouble diagnostics toggle<cr>",
					desc = "Diagnostics (Trouble)",
				},
				{
					"<leader>xX",
					"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
					desc = "Buffer Diagnostics (Trouble)",
				},
				{
					"<leader>cs",
					"<cmd>Trouble symbols toggle focus=false<cr>",
					desc = "Symbols (Trouble)",
				},
				{
					"<leader>cl",
					"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
					desc = "LSP Definitions / references / ... (Trouble)",
				},
				{
					"<leader>xL",
					"<cmd>Trouble loclist toggle<cr>",
					desc = "Location List (Trouble)",
				},
				{
					"<leader>xQ",
					"<cmd>Trouble qflist toggle<cr>",
					desc = "Quickfix List (Trouble)",
				},
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
			"cshuaimin/ssr.nvim",
			module = "ssr",
			config = function()
				require("ssr").setup({
					border = "rounded",
					min_width = 50,
					min_height = 5,
					max_width = 120,
					max_height = 25,
					adjust_window = true,
					keymaps = {
						close = "q",
						next_match = "n",
						prev_match = "N",
						replace_confirm = "<cr>",
						replace_all = "<leader><cr>",
					},
				})
				vim.keymap.set({ "n", "x" }, "<leader>sr", function()
					require("ssr").open()
				end)
			end,
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
					svelte = { "prettier" },
					typescript = { "prettier", "biome", stop_after_first = true },
					typescriptreact = { "prettier", "biome", stop_after_first = true },
					zig = { "zigfmt" },
				},
			},
		},
		{
			"kevinhwang91/nvim-hlslens",
			opts = { calm_down = true, nearest_only = true, nearest_float_when = "always" },
		},
		{
			"smjonas/live-command.nvim",
			config = function()
				require("live-command").setup({
					commands = {
						Norm = { cmd = "norm" },
					},
				})
			end,
		},
		{
			"shellRaining/hlchunk.nvim",
			event = { "BufReadPre", "BufNewFile" },
			opts = { line_num = { enable = true } },
		},
	},
})

-- tokyonight-night
-- tokyonight-storm
-- tokyonight-moon
-- rose-pine-main
-- rose-pine-moon
-- github_dark
-- github_dark_default
-- github_dark_dimmed
-- github_dark_high_contrast
-- oxocarbon
-- moonfly
-- midnight
-- onedark_dark
vim.cmd("colorscheme onedark_dark")
