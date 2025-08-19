return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			auto_install = true,
			indent = { enable = true },
			highlight = { enable = true, additional_vim_regex_highlighting = false, use_languagetree = true },
			ensure_installed = { "diff", "lua", "luadoc", "markdown", "markdown_inline", "vimdoc" },
		})
	end,
}
