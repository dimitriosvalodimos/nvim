return {
	"roobert/surround-ui.nvim",
	dependencies = { "kylechui/nvim-surround", "folke/which-key.nvim" },
	version = "*",
	event = "VeryLazy",
	config = function()
		require("surround-ui").setup({ root_key = "S" })
		require("nvim-surround").setup({})
	end,
}
