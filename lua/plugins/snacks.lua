return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = { enabled = true },
		picker = { enabled = true },
		explorer = { enabled = true },
		words = { enabled = true },
	},
	keys = {
		{ "<leader>fr", ":lua require('snacks').picker.resume()<cr>", desc = "resume search" },
		{ "<leader>fR", ":lua require('snacks').picker.registers()<cr>", desc = "register search" },
		{ "<leader>ff", ":lua require('snacks').picker.files()<cr>", desc = "file search" },
		{ "<leader>fg", ":lua require('snacks').picker.grep()<cr>", desc = "word search" },
		{ "<leader>fb", ":lua require('snacks').picker.buffers()<cr>", desc = "buffer search" },
		{ "<leader>fw", ":lua require('snacks').picker.grep_word()<cr>", desc = "word/selection search" },
		{ "<leader>fh", ":lua require('snacks').picker.help()<cr>", desc = "helptag search" },
		{ "<leader>fk", ":lua require('snacks').picker.keymaps()<cr>", desc = "keymap search" },
		{ "<leader>/", ":lua require('snacks').picker.grep_buffers()<cr>", desc = "active buffer search" },
		{ "<leader>e", ":lua require('snacks').picker.explorer()<cr>", desc = "file explorer" },
	},
}
