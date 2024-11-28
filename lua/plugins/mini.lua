local map = require("config.utils").map
return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
		require("mini.icons").setup()
		require("mini.extra").setup()
		require("mini.tabline").setup()
		require("mini.statusline").setup()
		require("mini.completion").setup()
		require("mini.pairs").setup()
		require("mini.pick").setup()
		require("mini.git").setup()
		require("mini.comment").setup()
		require("mini.move").setup()

		map("i", "<Tab>", [[pumvisible() ? "\<C-n>\<C-y>" : "\<Tab>"]], { expr = true })
		map("n", "<leader>ff", ":Pick files<cr>", "find files")
		map("n", "<leader>fh", ":Pick help<cr>", "find helptag")
		map("n", "<leader>fb", ":Pick buffers<cr>", "find buffer")
		map("n", "<leader>fg", ":Pick grep_live<cr>", "find pattern")
		map("n", "<leader>fk", ":Pick keymaps<cr>", "find keymap")
		map("n", "<leader>fm", ":Pick marks<cr>", "find marks")
		map("n", "<leader>fr", ":Pick resume<cr>", "resume search")
		map("n", "<leader>fR", ":Pick registers<cr>", "find register")
		map("n", "<leader>xx", ":Pick diagnostic<cr>", "find keymap")
		map("n", "-", ":lua require('mini.files').open()<cr>", "open files")
	end,
}
