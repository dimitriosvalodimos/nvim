return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
			},
		},
		tag = "0.1.8",
		config = function()
			local telescope = require("telescope")
			telescope.setup({
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "ignore_case",
					},
				},
				defaults = require("telescope.themes").get_ivy({
					previewer = false,
					layout_config = { prompt_position = "bottom" },
				}),
				pickers = {
					current_buffer_fuzzy_find = { previewer = true },
					live_grep = { previewer = true },
				},
			})
			telescope.load_extension("fzf")
		end,
		keys = {
			{ "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", desc = "find help tags" },
			{ "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", desc = "find buffers" },
			{ "<leader>fk", "<cmd>lua require('telescope.builtin').keymaps()<cr>", desc = "find keymaps" },
			{ "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", desc = "find files" },
			{ "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", desc = "find live" },
			{ "<leader>fr", "<cmd>lua require('telescope.builtin').resume()<cr>", desc = "resume search" },
			{ "<leader>fR", "<cmd>lua require('telescope.builtin').registers()<cr>", desc = "registers" },
			{
				"<leader>/",
				"<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>",
				desc = "find in file",
			},
			{
				"<leader>f/",
				"<cmd>lua require('telescope.builtin').live_grep({ grep_open_files = true })<cr>",
				desc = "find in open files",
			},
		},
	},
}
