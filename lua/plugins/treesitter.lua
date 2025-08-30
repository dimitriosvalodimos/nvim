require("nvim-treesitter.configs").setup({
	auto_install = true,
	highlight = { enable = true, additional_vim_regex_highlighting = false, use_languagetree = true },
	incremental_selection = { enable = true, keymaps = { node_incremental = "v", node_decremental = "V" } },
	ensure_installed = { "diff", "lua", "luadoc", "markdown", "markdown_inline", "vimdoc" },
})
