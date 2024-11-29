return {
	{
		"lewis6991/gitsigns.nvim",
		opts = {},
		event = "BufEnter",
		keys = { { "<leader>gs", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "toggle git blame" } },
	},
}
