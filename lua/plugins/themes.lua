return {
	{ "aktersnurra/no-clown-fiesta.nvim", lazy = true, priority = 1000, opts = {} },
	{
		"blazkowolf/gruber-darker.nvim",
		lazy = true,
		priority = 1000,
		opts = { italic = { strings = false, comments = false, operators = false, folds = false } },
	},
	{ "Mofiqul/vscode.nvim", lazy = true, priority = 1000, opts = { transparent = false, italic_comments = false } },
	{ "olivercederborg/poimandres.nvim", lazy = true, priority = 1000, opts = { disable_italics = true } },
	{
		"killitar/obscure.nvim",
		lazy = true,
		priority = 1000,
		opts = {
			styles = {
				keywords = { italic = false, bold = true },
				functions = { bold = true },
				booleans = {
					bold = true,
				},
			},
		},
	},
}
