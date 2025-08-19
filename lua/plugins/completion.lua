return {
	{ "windwp/nvim-autopairs", opts = {} },
	{
		"saghen/blink.cmp",
		version = "1.*",
		event = "InsertEnter",
		dependencies = { "rafamadriz/friendly-snippets", "windwp/nvim-autopairs" },
		opts = {
			signature = { enabled = true },
			fuzzy = { implementation = "prefer_rust" },
			appearance = { nerd_font_variant = "normal" },
			completion = { documentation = { auto_show = true } },
			sources = { default = { "lsp", "path", "snippets", "buffer" } },
			keymap = {
				preset = "enter",
				["<Tab>"] = { "select_next", "fallback" },
				["<S-Tab>"] = { "select_prev", "fallback" },
			},
		},
	},
}
