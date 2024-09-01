return {
	"echasnovski/mini.nvim",
	config = function()
		require("mini.pairs").setup()
		require("mini.tabline").setup()
		require("mini.completion").setup()
	end,
}
