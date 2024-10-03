return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		"andymass/vim-matchup",
	},
	config = function()
		require("nvim-treesitter.install").prefer_git = true
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"css",
				"diff",
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
			},
			auto_install = true,
			matchup = { enable = true, enable_quotes = true },
			highlight = { enable = true, additional_vim_regex_highlighting = false },
		})
	end,
}
