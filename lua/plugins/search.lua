return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	tag = "0.1.8",
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
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case", -- ignore_case, respect_case
				},
			},
		})
		telescope.load_extension("fzf")
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "find help" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "find buffer" })
		vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "find keymapping" })
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "find file" })
		vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "find current word" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "live grep" })
		vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "find diagnostics" })
		vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "resume search" })
		vim.keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = 'find recent files ("." for repeat)' })
		vim.keymap.set("n", "<leader>/", function()
			builtin.current_buffer_fuzzy_find(
				require("telescope.themes").get_dropdown({ winblend = 10, previewer = false })
			)
		end, { desc = "fuzzy find in buffer" })
		vim.keymap.set("n", "<leader>f/", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			})
		end, { desc = "find in open files" })
	end,
}
