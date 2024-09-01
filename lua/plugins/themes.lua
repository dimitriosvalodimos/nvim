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
}
