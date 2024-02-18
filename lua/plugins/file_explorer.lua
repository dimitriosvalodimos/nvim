return {
	{
		"stevearc/oil.nvim",
		config = function()
			require("oil").setup({})
			vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "open directory" })
		end,
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{

		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup({
				close_if_last_window = false,
				popup_border_style = "rounded",
				enable_git_status = true,
				enable_diagnostics = true,
				enable_normal_mode_for_inputs = false,
				open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
				sort_case_insensitive = true,

				window = { position = "right" },
				filesystem = {
					filtered_items = {
						visible = true,
						hide_dotfiles = false,
						hide_gitignored = false,
						hide_hidden = false,
					},
					hijack_netrw_behavior = "open_default",
					use_libuv_file_watcher = true,
				},
			})

			vim.keymap.set("n", "<c-e>", "<cmd>Neotree filesystem toggle<cr>", { desc = "file explorer" })
		end,
	},
}
