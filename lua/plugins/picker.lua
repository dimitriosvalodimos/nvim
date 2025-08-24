return {
	"ibhagwan/fzf-lua",
	config = function()
		local fzf = require("fzf-lua")
		fzf.setup({ { "max-perf", "border-fused", "hide" } })
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
