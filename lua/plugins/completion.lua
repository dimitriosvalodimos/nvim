return {
	{
		"saghen/blink.cmp",
		lazy = false,
		version = "v0.*",
		opts = {
			keymap = { preset = "enter" }, -- default, super-tab, enter
			appearance = { use_nvim_cmp_as_default = true },
			sources = { cmdline = {}, default = { "lsp", "path", "snippets", "buffer" } },
			completion = {
				documentation = { auto_show = true },
				menu = { draw = { treesitter = { "lsp" } } },
				accept = { auto_brackets = { enabled = true } },
			},
			signature = { enabled = true },
		},
	},
}
