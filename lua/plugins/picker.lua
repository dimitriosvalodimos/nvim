return {
	"ibhagwan/fzf-lua",
	opts = { { "max-perf", "border-fused", "hide" } },
	config = function(_, opts)
		local fzf = require("fzf-lua")
		fzf.setup(opts)
		fzf.register_ui_select()
	end,
	keys = {
		{ "<leader>ff", ":FzfLua files<cr>" },
		{ "<leader>fg", ":FzfLua live_grep_native<cr>" },
		{ "<leader>fb", ":FzfLua buffers<cr>" },
		{ "<leader>fr", ":FzfLua resume<cr>" },
		{ "<leader>/", ":FzfLua grep_curbuf<cr>" },
		{ "<leader>xx", ":FzfLua diagnostics_document<cr>" },
	},
}
