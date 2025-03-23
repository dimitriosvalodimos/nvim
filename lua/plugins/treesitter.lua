local languages = {
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
	"rust",
	"sql",
	"vimdoc",
	"tsx",
	"typescript",
}
return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.install").prefer_git = true
		require("nvim-treesitter.configs").setup({
			auto_install = true,
			ensure_installed = languages,
			highlight = { enable = true, additional_vim_regex_highlighting = false },
		})
	end,
}
