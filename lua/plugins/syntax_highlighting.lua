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
	"regex",
	"sql",
	"tsx",
	"typescript",
}

return {
	{ "numToStr/Comment.nvim", opts = {} },
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		ft = languages,
		dependencies = { "andymass/vim-matchup" },
		config = function()
			require("nvim-treesitter.install").prefer_git = true
			require("nvim-treesitter.configs").setup({
				ensure_installed = languages,
				auto_install = true,
				matchup = { enable = true },
				highlight = { enable = true, additional_vim_regex_highlighting = false },
			})
		end,
	},
}
