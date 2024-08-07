local g = vim.g
local opt = vim.opt

g.mapleader = " "
g.maplocalleader = ","

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
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"miikanissi/modus-themes.nvim",
		priority = 1000,
		lazy = true,
		opts = {
			variant = "default", -- default, tinted, deuteranopia, tritanopia
			dim_inactive = true,
			hide_inactive_statusline = true,
			styles = {
				comments = { italic = false },
				keywords = { bold = true },
				functions = { bold = true },
				variables = {},
			},
		},
	},
	{ "nyoom-engineering/oxocarbon.nvim", lazy = true, priority = 1000 },
	{ "dasupradyumna/midnight.nvim", lazy = true, priority = 1000 },
	{ "akinsho/bufferline.nvim", requires = "nvim-tree/nvim-web-devicons", opts = {} },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = { options = { theme = "auto" } },
	},
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"m-demare/hlargs.nvim",
			"andymass/vim-matchup",
			"windwp/nvim-ts-autotag",
		},
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"c",
					"cpp",
					"css",
					"diff",
					"go",
					"gomod",
					"gosum",
					"html",
					"java",
					"javascript",
					"jsdoc",
					"json",
					"kotlin",
					"lua",
					"luadoc",
					"markdown",
					"markdown_inline",
					"sql",
					"typescript",
					"vim",
					"vimdoc",
					"vue",
				},
				sync_install = false,
				auto_install = true,
				highlight = { enable = true, additional_vim_regex_highlighting = false, use_languagetree = true },
				indent = { enable = true },
				matchup = { enable = true },
			})
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true,
					enable_rename = true,
					enable_close_on_slash = true,
				},
			})
			require("hlargs").setup({})
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
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
						case_mode = "smart_case",
					},
				},
			})
			telescope.load_extension("fzf")
		end,
		keys = {
			{ "<leader>ff", '<cmd>lua require("telescope.builtin").find_files()<cr>', desc = "find file" },
			{ "<leader>fg", '<cmd>lua require("telescope.builtin").live_grep()<cr>', desc = "search" },
			{ "<leader>fb", '<cmd>lua require("telescope.builtin").buffers()<cr>', desc = "find buffer" },
			{ "<leader>fh", '<cmd>lua require("telescope.builtin").help_tags()<cr>', desc = "find helptag" },
		},
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"onsails/lspkind-nvim",
			"ray-x/cmp-treesitter",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"luckasRanarison/tailwind-tools.nvim",
			{ "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
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
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")
			local tailwind = require("tailwind-tools")
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")

			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

			tailwind.setup({
				document_color = {
					enabled = true,
					kind = "background",
					inline_symbol = "󰝤 ",
					debounce = 500,
				},
				conceal = {
					enabled = true,
					min_length = nil,
					symbol = "󱏿",
					highlight = {
						fg = "#38BDF8",
					},
				},
			})

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				formatting = {
					format = lspkind.cmp_format({
						before = require("tailwind-tools.cmp").lspkind_format,
					}),
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
					["<CR>"] = cmp.mapping({
						i = function(fallback)
							if cmp.visible() and cmp.get_selected_entry() then -- cmp.get_active_entry() then
								cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
							else
								fallback()
							end
						end,
						s = cmp.mapping.confirm({ select = true }),
						c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
					}),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "nvim_lua" },
					{ name = "treesitter" },
					{ name = "buffer" },
				}),
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			{ "nvim-telescope/telescope.nvim" },
			{ "folke/neodev.nvim", opts = {} },
			{ "j-hui/fidget.nvim", opts = { progress = { ignore_done_already = true, ignore_empty_message = true } } },
		},
		config = function()
			require("mason").setup()
			local mason_lsp = require("mason-lspconfig")
			local lspconfig = require("lspconfig")

			local servers = {
				biome = {
					settings = {},
					filetypes = {
						"astro",
						"css",
						"javascript",
						"javascriptreact",
						"json",
						"jsonc",
						"svelte",
						"typescript",
						"typescriptreact",
						"typescript.tsx",
						"vue",
					},
				},
				cssls = {
					settings = {},
					filetypes = { "css", "scss", "less" },
				},
				cssmodules_ls = {
					settings = {},
					filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
				},
				emmet_ls = {
					settings = {},
					filetypes = {
						"astro",
						"css",
						"eruby",
						"html",
						"htmldjango",
						"javascriptreact",
						"less",
						"pug",
						"sass",
						"scss",
						"svelte",
						"typescriptreact",
						"vue",
					},
				},
				gopls = {
					settings = {},
					filetypes = { "go", "gomod", "gowork", "gotmpl" },
				},
				html = {
					settings = {},
					filetypes = { "html", "templ" },
				},
				lua_ls = {
					settings = {
						Lua = {
							completion = { callSnippet = "Replace" },
							workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
							telemetry = { enable = false },
							runtime = { version = "LuaJIT" },
							diagnostics = { globals = { "vim" } },
						},
					},
					filetypes = { "lua" },
				},
				svelte = {
					settings = {},
					filetypes = { "svelte" },
				},
				tailwindcss = {
					settings = {},
					filetypes = {
						"html",
						"css",
						"javascript",
						"javascriptreact",
						"svelte",
						"typescript",
						"typescriptreact",
						"vue",
					},
				},
				tsserver = {
					settings = {},
					filetypes = {
						"javascript",
						"javascriptreact",
						"javascript.jsx",
						"typescript",
						"typescriptreact",
						"typescript.tsx",
					},
				},
				volar = {
					settings = {},
					filetypes = { "vue" },
				},
			}

			local on_attach = function(client, bufnr)
				vim.api.nvim_create_autocmd("CursorHold", {
					buffer = bufnr,
					callback = function()
						local opts = {
							focusable = false,
							close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
							border = "rounded",
							source = "always",
							prefix = " ",
							scope = "cursor",
						}
						vim.diagnostic.open_float(nil, opts)
					end,
				})
			end

			local telescope_builtin = require("telescope.builtin")

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
			capabilities.textDocument.completion.completionItem.snippetSupport = true

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("config-lspattach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					map("K", vim.lsp.buf.hover, "hover docs")
					map("gD", vim.lsp.buf.declaration, "[g]oto [D]eclaration")
					map("gr", telescope_builtin.lsp_references, "[g]oto [r]eference")
					map("gd", telescope_builtin.lsp_definitions, "[g]oto [d]efinition")
					map("gI", telescope_builtin.lsp_implementations, "[g]oto [I]mplementation")
					map("<leader>D", telescope_builtin.lsp_type_definitions, "type [D]efinition")
					map("<leader>rn", vim.lsp.buf.rename, "[r]e[n]ame")
					map("<leader>ca", vim.lsp.buf.code_action, "[c]ode [a]ction")
					map("<leader>ds", telescope_builtin.lsp_document_symbols, "[d]ocument [s]ymbols")
					map("<leader>ws", telescope_builtin.lsp_dynamic_workspace_symbols, "[w]orkspace [s]ymbols")

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.documentHighlightProvider then
						local highlight_augroup = vim.api.nvim_create_augroup("config-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
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

					if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
						end, "toggle inlay hints")
					end
				end,
			})

			mason_lsp.setup({ ensure_installed = vim.tbl_keys(servers) })
			mason_lsp.setup_handlers({
				function(server_name)
					local server_config = servers[server_name] or {}

					lspconfig[server_name].setup({
						capabilities = capabilities,
						on_attach = on_attach,
						settings = server_config.settings or {},
						filetypes = server_config.filetypes or {},
					})
				end,
			})

			vim.diagnostic.config({
				virtual_text = { source = "if_many" },
				float = { source = "if_many" },
				signs = true,
				underline = true,
				update_in_insert = true,
				severity_sort = true,
			})

			local function preview_location_callback(_, result)
				if result == nil or vim.tbl_isempty(result) then
					return nil
				end
				vim.lsp.util.preview_location(result[1])
			end

			local function peek_definition()
				local params = vim.lsp.util.make_position_params()
				return vim.lsp.buf_request(0, "textDocument/definition", params, preview_location_callback)
			end

			vim.lsp.handlers["textDocument/definition"] = peek_definition()
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {
			notify_on_error = false,
			formatters_by_ft = {
				css = { { "prettier", "biome" } },
				go = { "gofumpt", "goimports", "golines" },
				html = { { "prettier", "biome" } },
				javascript = { { "prettier", "biome" } },
				javascriptreact = { { "prettier", "biome" } },
				json = { { "prettier", "biome" } },
				lua = { "stylua" },
				svelte = { "prettier" },
				typescript = { { "prettier", "biome" } },
				typescriptreact = { { "prettier", "biome" } },
				vue = { "prettier" },
			},
			format_on_save = { lsp_fallback = true, timeout_ms = 500 },
		},
	},
	{
		"stevearc/oil.nvim",
		opts = {},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = { { "-", "<cmd>Oil<cr>", desc = "open oil" } },
	},
	{ "folke/which-key.nvim", opts = { layout = { align = "center" } } },
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim",
			{ "akinsho/git-conflict.nvim", opts = {} },
			{
				"lewis6991/gitsigns.nvim",
				opts = {
					current_line_blame = false,
					current_line_blame_opts = {
						virt_text = true,
						virt_text_pos = "right_align",
						delay = 600,
						ignore_whitespace = false,
						virt_text_priority = 100,
					},
					current_line_blame_formatter = "<author>, <author_time:%d.%m.%Y> - <summary>",
					-- current_line_blame_formatter_opts = { relative_time = true },
					on_attach = function(bufnr)
						local gitsigns = require("gitsigns")
						local function map(mode, l, r, opts)
							opts = opts or {}
							opts.buffer = bufnr
							vim.keymap.set(mode, l, r, opts)
						end
						map("n", "]c", function()
							if vim.wo.diff then
								vim.cmd.normal({ "]c", bang = true })
							else
								gitsigns.nav_hunk("next")
							end
						end)
						map("n", "[c", function()
							if vim.wo.diff then
								vim.cmd.normal({ "[c", bang = true })
							else
								gitsigns.nav_hunk("prev")
							end
						end)
						map("n", "<leader>hs", gitsigns.stage_hunk)
						map("n", "<leader>hr", gitsigns.reset_hunk)
						map("v", "<leader>hs", function()
							gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
						end)
						map("v", "<leader>hr", function()
							gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
						end)
						map("n", "<leader>hS", gitsigns.stage_buffer)
						map("n", "<leader>hu", gitsigns.undo_stage_hunk)
						map("n", "<leader>hR", gitsigns.reset_buffer)
						map("n", "<leader>hp", gitsigns.preview_hunk)
						map("n", "<leader>hb", function()
							gitsigns.blame_line({ full = true })
						end)
						map("n", "<leader>tb", gitsigns.toggle_current_line_blame)
						map("n", "<leader>hd", gitsigns.diffthis)
						map("n", "<leader>hD", function()
							gitsigns.diffthis("~")
						end)
						map("n", "<leader>td", gitsigns.toggle_deleted)
						map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
					end,
				},
			},
		},
		opts = {},
	},
	{
		"kevinhwang91/nvim-hlslens",
		opts = { calm_down = true, nearest_only = true, nearest_float_when = "always" },
	},
	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		opts = { use_diagnostic_signs = true },
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr><cr>",
				desc = "toggle buffer diagnostics",
			},
			{ "<leader>xX", "<cmd>Trouble diagnostics toggle<cr>", desc = "toggle workspace diagnostics" },
			{ "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "toggle symbols" },
			{ "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "toggle lsp" },
			{ "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "toggle loclist" },
			{ "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "toggle quickfix" },
		},
	},
	{ "ivanjermakov/troublesum.nvim", opts = {} },
	{
		"folke/todo-comments.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},
	{
		"folke/ts-comments.nvim",
		opts = {},
		event = "VeryLazy",
		enabled = vim.fn.has("nvim-0.10.0") == 1,
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({ "*" })
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
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
	},
}, {})

-- modus_vivendi
-- oxocarbon
-- midnight
vim.cmd("colorscheme oxocarbon")
