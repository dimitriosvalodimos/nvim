return {
	{
		"blazkowolf/gruber-darker.nvim",
		lazy = true,
		priority = 1000,
		opts = { invert = { signs = true }, italic = { strings = false, comments = false } },
	},
	{ "rockyzhang24/arctic.nvim", branch = "v2", dependencies = { "rktjmp/lush.nvim" }, lazy = true, priority = 1000 },
	{ "nyoom-engineering/oxocarbon.nvim", lazy = true, priority = 1000 },
}
