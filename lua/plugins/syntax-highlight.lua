return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		"andymass/vim-matchup",
		"windwp/nvim-ts-autotag",
	},
	config = function()
		require("nvim-treesitter.install").prefer_git = true
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"bash",
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
				"svelte",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
			},
			auto_install = true,
			matchup = { enable = true },
			highlight = { enable = true },
		})
		require("nvim-ts-autotag").setup({
			opts = {
				enable_close = true,
				enable_rename = true,
				enable_close_on_slash = true,
			},
		})
	end,
}
