return {
	"folke/snacks.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		bigfile = { enabled = true },
		notifier = { enabled = true },
		quickfile = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = false },
	},
	keys = {
		{ "<leader>lg", "<cmd>lua require('snacks').lazygit()<cr>", desc = "lazygit" },
		{ "<leader>gb", "<cmd>lua require('snacks').gitbrowse()<cr>", desc = "git browse" },
		{ "<leader>bd", "<cmd>lua require('snacks').bufdelete()<cr>", desc = "Delete Buffer" },
	},
}
