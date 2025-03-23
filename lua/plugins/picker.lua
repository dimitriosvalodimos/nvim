local map = require("config.utils").map
return {
	"ibhagwan/fzf-lua",
	opts = {},
	keys = {
		{ "<leader>ff", ":lua require('fzf-lua').files()<cr>", { desc = "find file" } },
		{ "<leader>fr", ":lua require('fzf-lua').resume()<cr>", { desc = "resume search" } },
		{ "<leader>fR", ":lua require('fzf-lua').registers()<cr>", { desc = "find register" } },
		{ "<leader>fb", ":lua require('fzf-lua').buffers()<cr>", { desc = "find buffer" } },
		{ "<leader>fg", ":lua require('fzf-lua').live_grep()<cr>", { desc = "find word" } },
		{ "<leader>fw", ":lua require('fzf-lua').grep_cword()<cr>", { desc = "find word under cursor" } },
		{ "<leader>fh", ":lua require('fzf-lua').helptags()<cr>", { desc = "find helptag" } },
		{ "<leader>fk", ":lua require('fzf-lua').keymaps()<cr>", { desc = "find keymap" } },
		{ "<leader>/", ":lua require('fzf-lua').lgrep_curbuf()<cr>", { desc = "find in buffer" } },
	},
}
