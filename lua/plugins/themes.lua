return {
	{
		"blazkowolf/gruber-darker.nvim",
		lazy = true,
		priority = 1000,
		opts = { { strings = false, comments = false, folds = false } },
	},
	{ "rose-pine/neovim", name = "rose-pine", lazy = true, priority = 1000, opts = { styles = { italic = false } } },
	{
		"mellow-theme/mellow.nvim",
		lazy = true,
		priority = 1000,
		config = function()
			vim.g.mellow_italic_comments = false
		end,
	},
	{
		"vague2k/vague.nvim",
		lazy = true,
		priority = 1000,
		opts = { style = { comments = "none", strings = "none", keyword_return = "none" } },
	},
}
