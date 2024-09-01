return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
		"nvim-telescope/telescope.nvim",
		{ "akinsho/git-conflict.nvim", version = "*", config = true },
		{
			"lewis6991/gitsigns.nvim",
			opts = {
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
			},
			keys = { { "<leader>gs", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "toggle blame" } },
		},
	},
	opts = {},
}
