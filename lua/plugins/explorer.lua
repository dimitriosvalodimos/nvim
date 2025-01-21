return {
	"stevearc/oil.nvim",
	dependencies = { "refractalize/oil-git-status.nvim" },
	opts = { columns = { "permissions", "size", "mtime", "icon" }, win_options = { signcolumn = "yes:2" } },
	config = function(_, opts)
		require("oil").setup(opts)
		require("oil-git-status").setup()
	end,
	keys = { { "-", ":Oil<cr>", desc = "file explorer" } },
}
