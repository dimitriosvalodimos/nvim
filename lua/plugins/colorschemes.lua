return {
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
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		lazy = true,
		opts = {
			transparent_background = false,
			show_end_of_buffer = false,
			term_colors = true,
			dim_inactive = {
				enabled = true,
				shade = "dark",
				percentage = 0.15,
			},
			no_italic = true,
			no_bold = false,
			no_underline = false,
			styles = {
				comments = { "italic" },
				conditionals = {},
				loops = {},
				functions = { "bold" },
				keywords = { "bold" },
				strings = {},
				variables = {},
				numbers = {},
				booleans = {},
				properties = {},
				types = { "bold,italic" },
				operators = {},
			},
			integrations = {
				alpha = true,
				dropbar = { enabled = true, color_mode = true },
				fidget = true,
				gitsigns = true,
				mason = true,
				neotree = true,
				neogit = true,
				cmp = true,
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { "bold" },
						hints = { "bold" },
						warnings = { "bold" },
						information = { "bold" },
					},
					underlines = {
						errors = { "underline" },
						hints = { "underline" },
						warnings = { "underline" },
						information = { "underline" },
					},
					inlay_hints = {
						background = true,
					},
				},
				semantic_tokens = true,
				treesitter_context = true,
				treesitter = true,
				telescope = { enabled = true },
				lsp_trouble = true,
				which_key = true,
			},
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
		"projekt0n/github-nvim-theme",
		lazy = true,
		priority = 1000,
		config = function()
			require("github-theme").setup({
				options = {
					compile_path = vim.fn.stdpath("cache") .. "/github-theme",
					compile_file_suffix = "_compiled",
					hide_end_of_buffer = true,
					hide_nc_statusline = true,
					transparent = false,
					terminal_colors = true,
					dim_inactive = true,
					module_default = true,
					styles = {
						comments = "italic",
						functions = "bold",
						keywords = "bold",
						variables = "NONE",
						conditionals = "NONE",
						constants = "bold",
						numbers = "NONE",
						operators = "NONE",
						strings = "NONE",
						types = "bold,italic",
					},
					inverse = {
						match_paren = true,
						visual = true,
						search = true,
					},
					darken = {
						floats = true,
						sidebars = {
							enabled = true,
						},
					},
				},
			})
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
					strings = true,
					emphasis = true,
					comments = true,
					operators = false,
					folds = true,
				},
				strikethrough = true,
				invert_selection = false,
				invert_signs = true,
				invert_tabline = true,
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
	{ "LunarVim/horizon.nvim", lazy = true, priority = 1000 },
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
}
