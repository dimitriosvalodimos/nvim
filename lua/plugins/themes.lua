return {
	{ "aktersnurra/no-clown-fiesta.nvim", lazy = true, priority = 1000, opts = {} },
	{
		"blazkowolf/gruber-darker.nvim",
		lazy = true,
		priority = 1000,
		opts = { italic = { strings = false, comments = false, operators = false, folds = false } },
	},
	{ "Mofiqul/vscode.nvim", lazy = true, priority = 1000, opts = { transparent = false, italic_comments = false } },
	{ "nyoom-engineering/oxocarbon.nvim", lazy = true, priority = 1000 },
	{ "olivercederborg/poimandres.nvim", lazy = true, priority = 1000, opts = { disable_italics = true } },
	{
		"mellow-theme/mellow.nvim",
		lazy = true,
		priority = 1000,
		config = function()
			vim.g.mellow_italic_comments = false
			vim.g.mellow_bold_keywords = true
			vim.g.mellow_bold_booleans = true
			vim.g.mellow_bold_functions = true
		end,
	},
	{
		"yazeed1s/oh-lucy.nvim",
		lazy = true,
		priority = 1000,
		config = function()
			vim.g.oh_lucy_italic_comments = false
			vim.g.oh_lucy_italic_keywords = false
			vim.g.oh_lucy_italic_variables = false
			vim.g.oh_lucy_evening_italic_comments = false
			vim.g.oh_lucy_evening_italic_keywords = false
			vim.g.oh_lucy_evening_italic_variables = false
		end,
	},
}
