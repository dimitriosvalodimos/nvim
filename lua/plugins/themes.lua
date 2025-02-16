return {
	{
		"blazkowolf/gruber-darker.nvim",
		lazy = true,
		priority = 1000,
		opts = { italic = { strings = false, comments = false, folds = false } },
	},
	{
		"olivercederborg/poimandres.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			bold_vert_split = true,
			dim_nc_background = true,
			disable_float_background = false,
			disable_italics = true,
		},
	},
}
