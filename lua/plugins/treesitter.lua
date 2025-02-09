local languages = {
	"css",
	"diff",
	"gleam",
	"html",
	"javascript",
	"jsdoc",
	"json",
	"lua",
	"luadoc",
	"markdown",
	"markdown_inline",
	"nim",
	"odin",
	"regex",
	"sql",
	"vimdoc",
	"tsx",
	"typescript",
}
return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = { "m-demare/hlargs.nvim", lazy = true, event = "VeryLazy", opts = {} },
	config = function()
		require("nvim-treesitter.install").prefer_git = true
		require("nvim-treesitter.configs").setup({
			auto_install = true,
			ensure_installed = languages,
			highlight = { enable = true, additional_vim_regex_highlighting = false },
			incremental_selection = { enable = true, keymaps = { node_incremental = "v", node_decremental = "V" } },
		})
	end,
}
