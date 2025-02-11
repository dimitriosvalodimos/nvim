return {
	"stevearc/oil.nvim",
	opts = {
		columns = { "icon", "permissions", "size", "mtime" },
		view_options = { show_hidden = true },
		win_options = { signcolumn = "yes:2" },
	},
	keys = { { "-", ":Oil<cr>", desc = "file explorer" } },
}
