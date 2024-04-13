local g = vim.g
local opt = vim.opt

g.mapleader = " "
g.maplocalleader = ","

opt.background = "dark"
opt.backspace:append({ "nostop" })
opt.breakindent = true
opt.clipboard = "unnamedplus"
opt.cmdheight = 0
opt.completeopt = { "menu", "menuone", "noselect" }
opt.conceallevel = 0
opt.copyindent = true
opt.cursorline = true
opt.diffopt:append("linematch:60")
opt.expandtab = true
opt.fileencoding = "utf-8"
opt.fillchars = { eob = " " }
opt.fillchars = {
	horiz = "━",
	horizup = "┻",
	horizdown = "┳",
	vert = "┃",
	vertleft = "┫",
	vertright = "┣",
	verthoriz = "╋",
}
opt.foldcolumn = "1"
opt.foldenable = true
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldmethod = "expr"
opt.hidden = true
opt.history = 1000
opt.hlsearch = true
opt.ignorecase = true
opt.infercase = true
opt.laststatus = 3
opt.linebreak = true
opt.mouse = "a"
opt.number = true
opt.preserveindent = true
opt.pumblend = 10
opt.pumheight = 10
opt.relativenumber = true
opt.ruler = false
opt.scrolloff = 8
opt.sessionoptions = { "curdir", "folds", "globals", "help", "tabpages", "terminal", "winsize" }
opt.shiftwidth = 2
opt.shortmess:append({ s = true, I = true })
opt.showmode = false
opt.showtabline = 2
opt.sidescrolloff = 8
opt.signcolumn = "yes"
opt.smartcase = true
-- opt.smoothscroll = true
opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true
opt.tabstop = 2
opt.termguicolors = true
opt.timeoutlen = 500
opt.title = true
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 300
opt.viewoptions:remove("curdir")
opt.virtualedit = "block"
opt.wildmode = "longest:full,full"
opt.wrap = false
opt.writebackup = false

if g.neovide then
	opt.guifont = "JetBrainsMono Nerd Font:h15"
	g.neovide_padding_top = 0
	g.neovide_padding_bottom = 0
	g.neovide_padding_right = 0
	g.neovide_padding_left = 0
	g.neovide_cursor_animation_length = 0
	g.neovide_cursor_trail_size = 0
	g.neovide_cursor_vfx_mode = ""
end

-- insert uuid
vim.keymap.set(
	"i",
	"<c-u>",
	"<c-r>=trim(system('uuidgen'))<cr>",
	{ desc = "insert uuid", noremap = true, silent = true }
)
vim.keymap.set(
	"n",
	"<c-u>",
	"i<c-r>=trim(system('uuidgen'))<cr><esc>",
	{ desc = "insert uuid", noremap = true, silent = true }
)

local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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
	{ "nyngwang/nvimgelion", lazy = true, priority = 1000 },
	{
		"sontungexpt/witch",
		priority = 1000,
		lazy = true,
		opts = {
			style = "dark",
			extras = {
				bracket = true,
				dashboard = true,
				diffview = true,
				explorer = true,
				indentline = true,
			},
		},
	},
	{
		"luisiacc/gruvbox-baby",
		lazy = true,
		priority = 1000,
		config = function()
			vim.g.gruvbox_baby_background_color = "medium"
			vim.g.gruvbox_baby_comment_style = "NONE"
			vim.g.gruvbox_baby_keyword_style = "NONE"
			vim.g.gruvbox_baby_telescope_theme = 1
		end,
	},
	{ "sekke276/dark_flat.nvim", lazy = true, priority = 1000, opts = { transparent = false, italics = false } },
	{
		"olimorris/onedarkpro.nvim",
		priority = 1000,
		lazy = true,
		opts = {
			styles = {
				types = "italic,bold",
				methods = "bold",
				numbers = "NONE",
				strings = "NONE",
				comments = "NONE",
				keywords = "bold",
				constants = "bold",
				functions = "bold",
				operators = "NONE",
				variables = "NONE",
				parameters = "NONE",
				conditionals = "NONE",
				virtual_text = "NONE",
			},
			plugins = { -- Override which plugin highlight groups are loaded
				aerial = true,
				barbar = true,
				copilot = true,
				dashboard = true,
				flash_nvim = true,
				gitsigns = true,
				hop = true,
				indentline = true,
				leap = true,
				lsp_saga = true,
				lsp_semantic_tokens = true,
				marks = true,
				mini_indentscope = true,
				neotest = true,
				neo_tree = true,
				nvim_cmp = true,
				nvim_bqf = true,
				nvim_dap = true,
				nvim_dap_ui = true,
				nvim_hlslens = true,
				nvim_lsp = true,
				nvim_navic = true,
				nvim_notify = true,
				nvim_tree = true,
				nvim_ts_rainbow = true,
				op_nvim = true,
				packer = true,
				polygot = true,
				rainbow_delimiters = true,
				startify = true,
				telescope = true,
				toggleterm = true,
				treesitter = true,
				trouble = true,
				vim_ultest = true,
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
		"folke/tokyonight.nvim",
		lazy = true,
		priority = 1000,
		opts = {
			transparent = false,
			terminal_colors = true,
			styles = {
				comments = { italic = true },
				keywords = { bold = true },
				functions = { bold = true },
				variables = {},
				sidebars = "dark",
				floats = "dark",
			},
			sidebars = { "qf", "help" },
			day_brightness = 0.3,
			hide_inactive_statusline = true,
			dim_inactive = true,
			lualine_bold = true,
		},
	},
	{
		"rose-pine/neovim",
		lazy = true,
		priority = 1000,
		config = function()
			require("rose-pine").setup({
				dark_variant = "main", -- main, moon, or dawn
				dim_inactive_windows = true,
				extend_background_behind_borders = true,
				enable = {
					terminal = true,
					legacy_highlights = false,
					migrations = true,
				},
				styles = {
					bold = true,
					italic = true,
					transparency = false,
				},
			})
		end,
	},
	{ "nyoom-engineering/oxocarbon.nvim", lazy = true, priority = 1000 },
	{
		"bluz71/vim-nightfly-colors",
		name = "nightfly",
		lazy = true,
		priority = 1000,
		config = function()
			vim.g.nightflyCursorColor = true
			vim.g.nightflyItalics = true
			vim.g.nightflyNormalFloat = true
			vim.g.nightflyTerminalColors = true
			vim.g.nightflyUndercurls = true
			vim.g.nightflyUnderlineMatchParen = true
			vim.g.nightflyVirtualTextColor = true
			vim.g.nightflyWinSeparator = 2
		end,
	},
	{
		"bluz71/vim-moonfly-colors",
		name = "moonfly",
		lazy = true,
		priority = 1000,
		config = function()
			vim.g.moonflyCursorColor = true
			vim.g.moonflyItalics = true
			vim.g.moonflyNormalFloat = true
			vim.g.moonflyTerminalColors = true
			vim.g.moonflyUndercurls = true
			vim.g.moonflyUnderlineMatchParen = true
			vim.g.moonflyVirtualTextColor = true
			vim.g.moonflyWinSeparator = 2
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		lazy = true,
		priority = 1000,
		config = function()
			require("gruvbox").setup({
				terminal_colors = true,
				undercurl = true,
				underline = true,
				bold = true,
				italic = {
					strings = false,
					emphasis = true,
					comments = false,
					operators = false,
					folds = true,
				},
				strikethrough = true,
				invert_selection = false,
				invert_signs = true,
				invert_tabline = false,
				invert_intend_guides = true,
				inverse = false,
				contrast = "",
				dim_inactive = true,
				transparent_mode = false,
			})
		end,
	},
	{
		"olivercederborg/poimandres.nvim",
		lazy = true,
		priority = 1000,
		config = function()
			require("poimandres").setup({
				bold_vert_split = true,
				dim_nc_background = true,
				disable_background = false,
				disable_float_background = false,
				disable_italics = false,
			})
		end,
	},
	{
		"tiagovla/tokyodark.nvim",
		lazy = true,
		priority = 1000,
		config = function()
			require("tokyodark").setup({
				transparent_background = false,
				gamma = 1.00,
				styles = {
					comments = { italic = true },
					keywords = { bold = true },
					identifiers = {},
					functions = { bold = true },
					variables = {},
				},
				terminal_colors = true,
			})
		end,
	},
	{
		"hoprr/calvera-dark.nvim",
		lazy = true,
		priority = 1000,
		config = function()
			vim.g.calvera_italic_keywords = false
			vim.g.calvera_borders = true
			vim.g.calvera_contrast = true
			vim.g.calvera_hide_eob = true
		end,
	},
	{
		"oxfist/night-owl.nvim",
		lazy = true,
		priority = 1000,
		config = function()
			require("night-owl").setup({
				bold = true,
				italics = true,
				underline = true,
				undercurl = true,
				transparent_background = false,
			})
		end,
	},
	{
		"zootedb0t/citruszest.nvim",
		lazy = true,
		priority = 1000,
		config = function()
			require("citruszest").setup({
				option = {
					transparent = false,
					bold = true,
					italic = true,
				},
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/nvim-treesitter-context",
			"windwp/nvim-ts-autotag",
			"andymass/vim-matchup",
			"lukas-reineke/headlines.nvim",
			"Wansmer/treesj",
			{ "m-demare/hlargs.nvim", opts = {} },
			{ "numToStr/Comment.nvim", opts = {} },
			{
				"drybalka/tree-climber.nvim",
				config = function()
					local config = { skip_comments = true, highlight = true, on_macro = true }
					local function keymap_func(command)
						return function()
							command(config)
						end
					end

					local tc = require("tree-climber")
					local wk = require("which-key")
					wk.register({ J = { name = "+jump" } }, { mode = { "n", "v", "o" } })

					vim.keymap.set({ "n", "v", "o" }, "JP", keymap_func(tc.goto_parent), { desc = "parent" })
					vim.keymap.set({ "n", "v", "o" }, "Jc", keymap_func(tc.goto_child), { desc = "child" })
					vim.keymap.set({ "n", "v", "o" }, "Jn", keymap_func(tc.goto_next), { desc = "next" })
					vim.keymap.set({ "n", "v", "o" }, "Jp", keymap_func(tc.goto_prev), { desc = "previous" })
					vim.keymap.set({ "v", "o" }, "in", function()
						tc.select_node(config)
					end, { noremap = true, silent = true, desc = "select node" })
				end,
			},
		},
		config = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }

			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"css",
					"diff",
					"erlang",
					"gitignore",
					"gleam",
					"go",
					"gomod",
					"gosum",
					"html",
					"javascript",
					"jsdoc",
					"json",
					"json5",
					"lua",
					"luadoc",
					"markdown",
					"markdown_inline",
					"query",
					"regex",
					"sql",
					"svelte",
					"tsx",
					"typescript",
					"vim",
					"vimdoc",
				},
				sync_install = false,
				auto_install = true,
				matchup = { enable = true },
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<c-space>",
						node_incremental = "<c-space>",
						scope_incremental = "<c-s>",
						node_decremental = "<M-space>",
					},
				},
				autotag = {
					enable = true,
					enable_rename = true,
					enable_close = true,
					enable_close_on_slash = true,
				},
				textobjects = {
					lsp_interop = {
						enable = true,
						border = "none",
						floating_preview_opts = {},
						peek_definition_code = {
							["<leader>df"] = "@function.outer",
							["<leader>dF"] = "@class.outer",
						},
					},
					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = {
							["]m"] = "@function.outer",
							["]]"] = "@class.outer",
						},
						goto_next_end = {
							["]M"] = "@function.outer",
							["]["] = "@class.outer",
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
							["[["] = "@class.outer",
						},
						goto_previous_end = {
							["[M"] = "@function.outer",
							["[]"] = "@class.outer",
						},
					},
					swap = {
						enable = true,
						swap_next = {
							["<leader>a"] = "@parameter.inner",
						},
						swap_previous = {
							["<leader>A"] = "@parameter.inner",
						},
					},
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
						},
					},
				},
			})

			local treesj = require("treesj")
			treesj.setup({})
			vim.keymap.set("n", "<leader>m", treesj.toggle, { desc = "Expand/Collapse" })
			vim.keymap.set("n", "<leader>M", function()
				treesj.toggle({ split = { recursive = true } })
			end, { desc = "Expand/Collapse recursive" })

			require("treesitter-context").setup({
				enable = true,
				max_lines = 8,
				min_window_height = 0,
				line_numbers = true,
				multiline_threshold = 1,
				trim_scope = "outer",
				mode = "topline",
				separator = nil,
				zindex = 20,
			})

			require("headlines").setup({})
		end,
	},
	{
		"luckasRanarison/tailwind-tools.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = { document_color = {
			kind = "background",
		} },
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				theme = "auto",
			},
		},
	},
	{ "Bekaboo/dropbar.nvim", opts = {} },
	{
		"nvim-telescope/telescope.nvim",
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

			local wk = require("which-key")
			wk.register({ s = { name = "+find" } }, { prefix = "<leader>" })

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "file" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "string" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "buffer" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "help tag" })
			vim.keymap.set("n", "<leader>fG", builtin.git_files, { desc = "git file" })
			vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "resume" })
			vim.keymap.set("n", "<leader>fF", builtin.current_buffer_fuzzy_find, { desc = "in current buffer" })
			vim.keymap.set("n", "<leader>fo", function()
				builtin.live_grep({ grep_open_files = true, prompt_title = "open files" })
			end, { desc = "open buffers" })
		end,
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"lewis6991/gitsigns.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("neogit").setup({})
			require("gitsigns").setup({
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
				current_line_blame = true,
				current_line_blame_formatter = "<author>, <author_time:%d.%m.%Y> - <summary>",
				current_line_blame_opts = { virt_text = true, virt_text_pos = "right_align" },
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns

					vim.keymap.set({ "n", "v" }, "]c", function()
						if vim.wo.diff then
							return "]c"
						end
						vim.schedule(function()
							gs.next_hunk()
						end)
						return "<Ignore>"
					end, { expr = true, desc = "Jump to next hunk" })
					vim.keymap.set({ "n", "v" }, "[c", function()
						if vim.wo.diff then
							return "[c"
						end
						vim.schedule(function()
							gs.prev_hunk()
						end)
						return "<Ignore>"
					end, { expr = true, desc = "Jump to previous hunk" })
					vim.keymap.set("v", "<leader>hs", function()
						gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "stage git hunk" })
					vim.keymap.set("v", "<leader>hr", function()
						gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "reset git hunk" })
					vim.keymap.set("n", "<leader>hs", gs.stage_hunk, { desc = "git stage hunk" })
					vim.keymap.set("n", "<leader>hr", gs.reset_hunk, { desc = "git reset hunk" })
					vim.keymap.set("n", "<leader>hS", gs.stage_buffer, { desc = "git Stage buffer" })
					vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, { desc = "undo stage hunk" })
					vim.keymap.set("n", "<leader>hR", gs.reset_buffer, { desc = "git Reset buffer" })
					vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { desc = "preview git hunk" })
					vim.keymap.set("n", "<leader>hb", function()
						gs.blame_line({ full = false })
					end, { desc = "git blame line" })
					vim.keymap.set("n", "<leader>hd", gs.diffthis, { desc = "git diff against index" })
					vim.keymap.set("n", "<leader>hD", function()
						gs.diffthis("~")
					end, { desc = "git diff against last commit" })
					vim.keymap.set("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "toggle git blame line" })
					vim.keymap.set("n", "<leader>td", gs.toggle_deleted, { desc = "toggle git show deleted" })
					vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "select git hunk" })
				end,
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind-nvim",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"rafamadriz/friendly-snippets",
			"luckasRanarison/tailwind-tools.nvim",
			"nvim-orgmode/orgmode",
			{
				"windwp/nvim-autopairs",
				opts = { disable_filetype = { "TelescopePrompt", "vim" }, enable_check_bracket_line = false },
			},
		},
		config = function()
			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			local cmp = require("cmp")
			local luasnip = require("luasnip")
			require("luasnip.loaders.from_vscode").lazy_load()
			luasnip.config.setup({})

			local lspkind = require("lspkind")

			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

			local winhighlight = {
				winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel",
			}

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(winhighlight),
					documentation = cmp.config.window.bordered(winhighlight),
				},
				formatting = {
					format = lspkind.cmp_format({ before = require("tailwind-tools.cmp").lspkind_format }),
				},
				mapping = cmp.mapping.preset.insert({
					["<c-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<c-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<c-u>"] = cmp.mapping.scroll_docs(-4),
					["<c-d>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping({
						i = cmp.mapping.complete(),
						c = function()
							if cmp.visible() then
								if not cmp.confirm({ select = true }) then
									return
								end
							else
								cmp.complete()
							end
						end,
					}),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "nvim_lua" },
					{ name = "orgmode" },
				}, {
					{ name = "buffer" },
					{ name = "nvim_lsp_signature_help" },
				}),
			})

			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				view = {
					entries = { name = "wildmenu", separator = "|" },
				},
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline(":", {
				enabled = function()
					local disabled = {
						IncRename = true,
					}
					local cmd = vim.fn.getcmdline():match("%S+")
					return not disabled[cmd] or cmp.close()
				end,
				mapping = cmp.mapping.preset.cmdline(),
				view = {
					entries = { name = "wildmenu", separator = "|" },
				},
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			"pmizio/typescript-tools.nvim",
			"dmmulroy/ts-error-translator.nvim",
			"nvim-lua/plenary.nvim",
			"mizlan/delimited.nvim",
			{ "folke/trouble.nvim", opts = {} },
			{ "folke/neodev.nvim", opts = {} },
			{ "j-hui/fidget.nvim", opts = { progress = { ignore_done_already = true, ignore_empty_message = true } } },
		},
		config = function()
			local servers = {
				basedpyright = { settings = {}, filetypes = { "python" } },
				cssls = { settings = {}, filetypes = { "css" } },
				cssmodules_ls = { settings = {}, filetypes = { "css" } },
				eslint = {
					settings = {},
					filetypes = { "css", "javascript", "typescript", "javascriptreact", "typescriptreact" },
				},
				biome = {
					settings = {},
					filetypes = {
						"javascript",
						"javascriptreact",
						"json",
						"jsonc",
						"typescript",
						"typescript.tsx",
						"typescriptreact",
						"astro",
						"svelte",
						"vue",
					},
				},
				emmet_ls = { settings = {}, filetypes = { "html", "javascriptreact", "typescriptreact" } },
				gopls = { settings = {}, filetypes = { "go", "gomod", "gosum" } },
				html = { settings = {}, filetypes = { "html" } },
				-- tsserver = {
				-- 	settings = {},
				-- 	filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
				-- },
				lua_ls = {
					settings = {
						Lua = {
							workspace = { checkThirdParty = false },
							telemetry = { enable = false },
							diagnostics = { disable = { "missing-fields" } },
							completion = {
								callSnippet = "Replace",
							},
						},
					},
					filetypes = { "lua" },
				},
				svelte = { settings = {}, filetypes = { "svelte" } },
				tailwindcss = { settings = {}, filetypes = { "javascriptreact", "typescriptreact", "svelte" } },
				rust_analyzer = { settings = {}, filetypes = { "rust" } },
			}

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
			capabilities.textDocument.completion.completionItem.snippetSupport = true

			local function on_attach(_, bufnr)
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

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = "single",
			})
			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signatureHelp, {
				border = "single",
			})
			vim.diagnostic.config({
				virtual_text = { source = "if_many" },
				signs = true,
				underline = true,
				update_in_insert = true,
				severity_sort = true,
				float = { source = "if_many", border = "single" },
			})

			require("mason").setup({})
			require("mason-lspconfig").setup({ ensure_installed = vim.tbl_keys(servers) })
			require("mason-lspconfig").setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({
						on_attach = on_attach,
						capabilities = capabilities,
						settings = (servers[server_name] or {}).settings,
						filetypes = (servers[server_name] or {}).filetypes,
					})
				end,
			})

			require("typescript-tools").setup({
				on_attach = function(client, bufnr)
					on_attach(client, bufnr)
					require("ts-error-translator").setup()
				end,
				capabilities = capabilities,
				filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
				settings = {
					separate_diagnostic_server = false,
					publish_diagnostic_on = "change",
					expose_as_code_action = { "all" },
					tsserver_path = nil,
					tsserver_plugins = { "@styled/typescript-styled-plugin" },
					tsserver_max_memory = 4096,
					tsserver_format_options = {},
					tsserver_file_preferences = {
						quotePreference = "auto",
						importModuleSpecifierEnding = "auto",
						jsxAttributeCompletionStyle = "auto",
						allowTextChangesInNewFiles = true,
						providePrefixAndSuffixTextForRename = true,
						allowRenameOfImportPath = true,
						includeAutomaticOptionalChainCompletions = true,
						provideRefactorNotApplicableReason = true,
						generateReturnInDocTemplate = true,
						includeCompletionsForImportStatements = true,
						includeCompletionsWithSnippetText = true,
						includeCompletionsWithClassMemberSnippets = true,
						includeCompletionsWithObjectLiteralMethodSnippets = true,
						useLabelDetailsInCompletionEntries = true,
						allowIncompleteCompletions = true,
						displayPartsForJSDoc = true,
						disableLineTextInReferences = true,
						includeInlayParameterNameHints = "none",
						includeInlayParameterNameHintsWhenArgumentMatchesName = false,
						includeInlayFunctionParameterTypeHints = false,
						includeInlayVariableTypeHints = false,
						includeInlayVariableTypeHintsWhenTypeMatchesName = false,
						includeInlayPropertyDeclarationTypeHints = false,
						includeInlayFunctionLikeReturnTypeHints = false,
						includeInlayEnumMemberValueHints = false,
					},
					tsserver_locale = "en",
					complete_function_calls = true,
					include_completions_with_insert_text = true,
					-- code_lens = "all",
					disable_member_code_lens = true,
					jsx_close_tag = {
						enable = false,
						filetypes = { "javascriptreact", "typescriptreact" },
					},
				},
			})

			local delimited = require("delimited")

			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
			vim.keymap.set("n", "[d", delimited.goto_prev)
			vim.keymap.set("n", "]d", delimited.goto_prev)
			vim.keymap.set("n", "[D", function()
				delimited.goto_prev({ severity = vim.diagnostic.severity.ERROR })
			end)
			vim.keymap.set("n", "]D", function()
				delimited.goto_next({ severity = vim.diagnostic.severity.ERROR })
			end)
			vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					local wk = require("which-key")
					wk.register({ g = { name = "+goto" } }, {})

					local tls_builtin = require("telescope.builtin")
					local function buf_keymap(command)
						return function()
							command({ buffer = ev.buf })
						end
					end

					vim.keymap.set("n", "gd", buf_keymap(tls_builtin.lsp_definitions), { desc = "definition" })
					vim.keymap.set("n", "gD", buf_keymap(vim.lsp.buf.declaration), { desc = "declaration" })
					vim.keymap.set("n", "gr", buf_keymap(tls_builtin.lsp_references), { desc = "reference" })
					vim.keymap.set("n", "gI", buf_keymap(tls_builtin.lsp_implementations), { desc = "implementation" })
					vim.keymap.set(
						"n",
						"gt",
						buf_keymap(tls_builtin.lsp_type_definitions),
						{ desc = "type definition" }
					)
					-- vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "hover info", buffer = ev.buf })
					-- vim.keymap.set("n", "<C-K>", vim.lsp.buf.signature_help, { desc = "signature help", buffer = ev.buf })
					vim.keymap.set("n", "<C-K>", vim.lsp.buf.hover, { desc = "hover info", buffer = ev.buf })
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "rename", buffer = ev.buf })
				end,
			})
			vim.keymap.set("n", "gR", function()
				require("trouble").toggle("lsp_references")
			end, { desc = "LSP references" })
			vim.keymap.set("n", "<leader>xx", function()
				require("trouble").toggle("workspace_diagnostics")
			end, { desc = "toggle diagnostics" })
		end,
	},
	{
		"stevearc/oil.nvim",
		config = function()
			require("oil").setup({})
			vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "open directory" })
		end,
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup({
				close_if_last_window = false,
				popup_border_style = "rounded",
				enable_git_status = true,
				enable_diagnostics = true,
				open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
				sort_case_insensitive = true,

				window = { position = "right" },
				filesystem = {
					filtered_items = {
						visible = true,
						hide_dotfiles = false,
						hide_gitignored = false,
						hide_hidden = false,
					},
					hijack_netrw_behavior = "open_default",
					use_libuv_file_watcher = true,
				},
			})

			vim.keymap.set("n", "<c-e>", "<cmd>Neotree filesystem toggle<cr>", { desc = "file explorer" })
		end,
	},
	{
		ft = { "commonlisp", "scheme", "fennel", "clojure", "racket" },
		"dundalek/parpar.nvim",
		dependencies = { "gpanders/nvim-parinfer", "julienvincent/nvim-paredit" },
		opts = {},
	},
	{
		"norcalli/nvim-colorizer.lua",
		opts = { "*" },
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			layout = { align = "center" },
		},
	},
	{
		"stevearc/conform.nvim",
		opts = {
			notify_on_error = false,
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "biome", "biome-check", "prettier" },
				typescript = { "biome", "biome-check", "prettier" },
				typescriptreact = { "biome", "biome-check", "prettier" },
				javascriptreact = { "biome", "biome-check", "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				svelte = { "prettier" },
				json = { "biome", "biome-check", "prettier" },
				python = { "isort", "black" },
				go = { "golines", "goimports", "gofumpt" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
		},
	},
	{
		"kevinhwang91/nvim-hlslens",
		opts = { calm_down = true, nearest_only = true, nearest_float_when = "always" },
	},
	{
		"nvim-pack/nvim-spectre",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			vim.keymap.set("n", "<leader>S", '<cmd>lua require("spectre").toggle()<CR>', {
				desc = "Toggle Spectre",
			})
			vim.keymap.set("n", "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
				desc = "Search current word",
			})
			vim.keymap.set("v", "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
				desc = "Search current word",
			})
			vim.keymap.set("n", "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
				desc = "Search on current file",
			})
		end,
	},
	{
		"malbertzard/inline-fold.nvim",
		config = function()
			require("inline-fold").setup({
				defaultPlaceholder = "…",
				queries = {
					html = {
						{ pattern = 'class="([^"]*)"' },
						{ pattern = 'href="(.-)"' },
						{ pattern = 'src="(.-)"' },
					},
					typescriptreact = {
						{ pattern = 'class="([^"]*)"' },
						{ pattern = "class='([^\"]*)'" },
						{ pattern = 'className="([^"]*)"' },
						{ pattern = "className='([^\"]*)'" },
						{ pattern = 'style="([^"]*)"' },
						{ pattern = "style='([^\"]*)'" },
						{ pattern = 'href="(.-)"' },
						{ pattern = "href='(.-)'" },
						{ pattern = 'src="(.-)"' },
						{ pattern = "src='(.-)'" },
					},
					javascriptreact = {
						{ pattern = 'class="([^"]*)"' },
						{ pattern = "class='([^\"]*)'" },
						{ pattern = 'className="([^"]*)"' },
						{ pattern = "className='([^\"]*)'" },
						{ pattern = 'style="([^"]*)"' },
						{ pattern = 'href="(.-)"' },
						{ pattern = 'src="(.-)"' },
					},
				},
			})

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
				pattern = { "*.html", "*.tsx" },
				callback = function()
					if not require("inline-fold.module").isHidden then
						vim.cmd("InlineFoldToggle")
					end
				end,
			})
		end,
	},
	{ "ellisonleao/glow.nvim", opts = {}, cmd = "Glow" },
	{ "nvim-orgmode/orgmode", opts = {} },
	{ "michaelb/sniprun", build = "sh ./install.sh", opts = {} },
})

-- calvera
-- citruszest
-- dark_flat
-- gruvbox
-- gruvbox-baby
-- moonfly
-- night-owl
-- nightfly
-- nvimgelion
-- onedark
-- onedark_dark
-- onedark_vivid
-- oxocarbon
-- poimandres
-- rose-pine-main
-- rose-pine-moon
-- tokyodark
-- tokyonight
-- tokyonight-moon
-- tokyonight-night
-- tokyonight-storm
-- witch
vim.cmd("colorscheme dark_flat")
