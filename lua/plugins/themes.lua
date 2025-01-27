return {
	{
		"blazkowolf/gruber-darker.nvim",
		lazy = true,
		priority = 1000,
		opts = { italic = { strings = false, comments = false, folds = false } },
	},
	{ "gmr458/cold.nvim", lazy = true, priority = 1000 },
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
	{
		"idr4n/github-monochrome.nvim",
		lazy = true,
		priority = 1000,
		opts = { style = "dark", styles = { comments = { italic = false } } },
	},
}
