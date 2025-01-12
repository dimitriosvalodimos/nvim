return {
	{
		"echasnovski/mini.nvim",
		version = false,
		config = function()
			require("mini.statusline").setup()
			require("mini.tabline").setup()
			require("mini.comment").setup()
			require("mini.ai").setup()
			require("mini.git").setup()
		end,
	},
}
