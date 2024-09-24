return {
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
			disable_italics = true,
		},
	},
	{
		"datsfilipe/vesper.nvim",
		lazy = true,
		priority = 1000,
		opts = {
			transparent = false,
			italics = {
				comments = false,
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
				comments = {},
				functions = { bold = true },
				keywords = { bold = true },
				lsp = { underline = true },
				match_paren = {},
				type = { bold = true },
				variables = {},
			},
		},
	},
	{
		"olimorris/onedarkpro.nvim",
		lazy = true,
		priority = 1000,
		opts = {
			styles = {
				types = "bold",
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
			filetypes = {
				c = true,
				comment = true,
				go = true,
				html = true,
				java = true,
				javascript = true,
				json = true,
				lua = true,
				markdown = true,
				php = true,
				python = true,
				ruby = true,
				rust = true,
				scss = true,
				toml = true,
				typescript = true,
				typescriptreact = true,
				vue = true,
				xml = true,
				yaml = true,
			},
			plugins = {
				gitsigns = true,
				nvim_cmp = true,
				nvim_hlslens = true,
				nvim_lsp = true,
				nvim_notify = true,
				nvim_ts_rainbow = true,
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
		"miikanissi/modus-themes.nvim",
		lazy = true,
		priority = 1000,
		config = function()
			require("modus-themes").setup({
				style = "auto",
				variant = "default", -- default, tinted, deuteranopia, tritanopia
				transparent = false,
				dim_inactive = false,
				hide_inactive_statusline = false,
				styles = {
					comments = {},
					keywords = { bold = true },
					functions = { bold = true },
					variables = {},
				},
			})
		end,
	},
	{
		"vague2k/vague.nvim",
		lazy = true,
		priority = 1000,
		opts = {
			transparent = false,
			style = {
				boolean = "none",
				number = "none",
				float = "none",
				error = "none",
				comments = "none",
				conditionals = "none",
				functions = "bold",
				headings = "bold",
				operators = "none",
				strings = "none",
				variables = "none",
				keywords = "bold",
				keyword_return = "bold",
				keywords_loop = "bold",
				keywords_label = "none",
				keywords_exception = "bold",
				builtin_constants = "bold",
				builtin_functions = "bold",
				builtin_types = "bold",
				builtin_variables = "none",
			},
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
				visual = true,
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
		"tiagovla/tokyodark.nvim",
		lazy = true,
		priority = 1000,
		opts = {
			transparent_background = false,
			gamma = 1.00,
			styles = {
				comments = {},
				keywords = { bold = true },
				identifiers = {},
				functions = { bold = true },
				variables = {},
			},
			terminal_colors = true,
		},
	},
	{
		"Mofiqul/vscode.nvim",
		lazy = true,
		priority = 1000,
		opts = {
			transparent = false,
			italic_comments = false,
			underline_links = true,
			disable_nvimtree_bg = false,
		},
	},
	{
		"mellow-theme/mellow.nvim",
		lazy = true,
		priority = 1000,
		config = function()
			vim.g.mellow_italic_comments = false
			vim.g.mellow_italic_keywords = false
			vim.g.mellow_italic_booleans = false
			vim.g.mellow_italic_functions = false
			vim.g.mellow_italic_variables = false
			vim.g.mellow_bold_comments = false
			vim.g.mellow_bold_keywords = true
			vim.g.mellow_bold_booleans = true
			vim.g.mellow_bold_functions = true
			vim.g.mellow_bold_variables = false
			vim.g.mellow_transparent = false
		end,
	},
	{
		"kvrohit/rasmus.nvim",
		lazy = true,
		priority = 1000,
		config = function()
			vim.g.rasmus_italic_comments = false
			vim.g.rasmus_italic_keywords = false
			vim.g.rasmus_italic_booleans = false
			vim.g.rasmus_italic_functions = false
			vim.g.rasmus_italic_variables = false
			vim.g.rasmus_bold_comments = false
			vim.g.rasmus_bold_keywords = false
			vim.g.rasmus_bold_booleans = false
			vim.g.rasmus_bold_functions = false
			vim.g.rasmus_bold_variables = false
			vim.g.rasmus_transparent = false
			vim.g.rasmus_variant = "dark" -- dark / monochrome
		end,
	},
	{ "felipeagc/fleet-theme-nvim", lazy = true, priority = 1000 },
	{
		"mrjones2014/lighthaus.nvim",
		lazy = true,
		priority = 1000,
		opts = {
			bg_dark = true,
			colors = {},
			lsp_underline_style = "undercurl",
			transparent = false,
			italic_comments = false,
			italic_keywords = false,
		},
	},
}
