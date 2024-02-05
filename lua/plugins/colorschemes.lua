return {
	{
		"folke/tokyonight.nvim",
		lazy = true,
		priority = 1000,
		opts = {
			transparent = false,
			terminal_colors = true,
			styles = {
				comments = { bold = true },
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
				comments = { "bold" },
				conditionals = {},
				loops = {},
				functions = { "bold" },
				keywords = { "bold" },
				strings = {},
				variables = {},
				numbers = {},
				booleans = {},
				properties = {},
				types = { "bold" },
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
					italic = false,
					transparency = true,
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
			vim.g.nightflyItalics = false
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
			vim.g.moonflyItalics = false
			vim.g.moonflyNormalFloat = true
			vim.g.moonflyTerminalColors = true
			vim.g.moonflyUndercurls = true
			vim.g.moonflyUnderlineMatchParen = true
			vim.g.moonflyVirtualTextColor = true
			vim.g.moonflyWinSeparator = 2
		end,
	},
}
