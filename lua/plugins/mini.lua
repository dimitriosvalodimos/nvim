return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
		require("mini.ai").setup()
		require("mini.comment").setup()
		require("mini.extra").setup()
		require("mini.git").setup()
		require("mini.icons").setup()
		require("mini.move").setup()
		require("mini.statusline").setup()
		require("mini.tabline").setup()
	end,
}
