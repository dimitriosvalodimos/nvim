return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
		},
	},
	config = function()
		local telescope = require("telescope")
		telescope.setup({
			defaults = require("telescope.themes").get_ivy({ border = false }),
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "ignore_case",
				},
			},
		})
		local map = require("config.utils").map
		local builtin = require("telescope.builtin")
		map("n", "<leader>ff", builtin.find_files, { desc = "find file" })
		map("n", "<leader>fg", builtin.live_grep, { desc = "find word" })
		map("n", "<leader>fb", builtin.buffers, { desc = "find buffer" })
		map("n", "<leader>fh", builtin.help_tags, { desc = "find helptag" })
		map("n", "<leader>fr", builtin.resume, { desc = "resume picker" })
		map("n", "<leader>fk", builtin.keymaps, { desc = "find keymap" })
		map("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "find in buffer" })
	end,
}
