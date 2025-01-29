return {
	{
		"blazkowolf/gruber-darker.nvim",
		lazy = true,
		priority = 1000,
		opts = { italic = { strings = false, comments = false, folds = false } },
	},
	{ "aktersnurra/no-clown-fiesta.nvim", lazy = true, priority = 1000, opts = {} },
	{
		"wnkz/monoglow.nvim",
		lazy = true,
		priority = 1000,
		opts = {
			on_colors = function(colors)
				colors.glow = "#00E676"
			end,
		},
	},
}
