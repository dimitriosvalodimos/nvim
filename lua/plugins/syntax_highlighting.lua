local languages = {
	"css",
	"diff",
	"go",
	"gomod",
	"gosum",
	"html",
	"javascript",
	"jsdoc",
	"json",
	"lua",
	"luadoc",
	"markdown",
	"markdown_inline",
	"odin",
	"regex",
	"sql",
	"vimdoc",
	"tsx",
	"typescript",
	"zig",
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		ft = languages,
		config = function()
			require("nvim-treesitter.install").prefer_git = true
			require("nvim-treesitter.configs").setup({
				ensure_installed = languages,
				auto_install = true,
				matchup = { enable = true },
				incremental_selection = { enable = true, keymaps = { node_incremental = "v", node_decremental = "V" } },
				highlight = { enable = true, additional_vim_regex_highlighting = false },
			})
		end,
	},
}
