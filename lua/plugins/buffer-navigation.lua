return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{ "<leader>ma", "<cmd>lua require('harpoon'):list():add()<cr>", desc = "Mark: add" },
		{ "<leader>m1", "<cmd>lua require('harpoon'):list():select(1)<cr>", desc = "Mark: Jump to 1" },
		{ "<leader>m2", "<cmd>lua require('harpoon'):list():select(2)<cr>", desc = "Mark: Jump to 2" },
		{ "<leader>m3", "<cmd>lua require('harpoon'):list():select(3)<cr>", desc = "Mark: Jump to 3" },
		{ "<leader>m4", "<cmd>lua require('harpoon'):list():select(4)<cr>", desc = "Mark: Jump to 4" },
		{ "<leader>m4", "<cmd>lua require('harpoon'):list():select(4)<cr>", desc = "Mark: Jump to 4" },
		{
			"<leader>ml",
			"<cmd>lua require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())<cr>",
			desc = "Mark: open list",
		},
		{ "<leader>mn", "<cmd>lua require('harpoon'):list():next()<cr>", desc = "Mark: Jump to next" },
		{ "<leader>mp", "<cmd>lua require('harpoon'):list():prev()<cr>", desc = "Mark: Jump to previous" },
		{ "<leader>mcc", "<cmd>lua require('harpoon'):list():clear()<cr>", desc = "Mark: clear list" },
	},
}
