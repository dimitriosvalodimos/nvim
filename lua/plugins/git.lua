return {
	{

		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewRefresh" },
	},
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		config = true,
		cmd = {
			"GitConflictListQf",
			"GitConflictPrevConflict",
			"GitConflictNextConflict",
			"GitConflictChooseNone",
			"GitConflictChooseBoth",
			"GitConflictChooseTheirs",
			"GitConflictChooseOurs",
		},
	},
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
}
