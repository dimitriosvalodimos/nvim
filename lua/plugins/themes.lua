return {
	{
		"aktersnurra/no-clown-fiesta.nvim",
		lazy = true,
		priority = 1000,
		opts = {
			styles = { functions = { bold = true }, keywords = { bold = true }, match_paren = { underline = true } },
		},
	},
	{
		"blazkowolf/gruber-darker.nvim",
		lazy = true,
		priority = 1000,
		opts = { italic = { strings = false, comments = false, folds = false } },
	},
	{ "olivercederborg/poimandres.nvim", lazy = true, priority = 1000, opts = { disable_italics = true } },
}
