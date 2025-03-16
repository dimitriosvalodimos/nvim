return {
	{
		"blazkowolf/gruber-darker.nvim",
		lazy = true,
		priority = 1000,
		opts = { invert = { signs = true }, italic = { strings = false, comments = false } },
	},
	{ "rockyzhang24/arctic.nvim", branch = "v2", dependencies = { "rktjmp/lush.nvim" }, lazy = true, priority = 1000 },
	{
		"datsfilipe/vesper.nvim",
		lazy = true,
		priority = 1000,
		opts = {
			palette_overrides = { bg = "#1E1E1E" },
			italics = { comments = false, keywords = false, functions = false, strings = false, variables = false },
		},
	},
}
