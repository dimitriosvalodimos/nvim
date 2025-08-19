return {
	"ibhagwan/fzf-lua",
	opts = { { "hide" } },
	keys = {
		{ "<leader>ff", ":FzfLua files<cr>" },
		{ "<leader>fg", ":FzfLua live_grep_native<cr>" },
		{ "<leader>fb", ":FzfLua buffers<cr>" },
		{ "<leader>fr", ":FzfLua resume<cr>" },
		{ "<leader>/", ":FzfLua grep_curbuf<cr>" },
		{ "<leader>xx", ":FzfLua diagnostics_document<cr>" },
	},
}
