return {
	"folke/trouble.nvim",
	opts = {},
	cmd = "Trouble",
	keys = {
		{ "<leader>XX", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
		{
			"<leader>xx",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			desc = "Buffer Diagnostics (Trouble)",
		},
		{ "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
	},
}
