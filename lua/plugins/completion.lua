return {
	{
		"saghen/blink.cmp",
		version = "1.*",
		event = "InsertEnter",
		dependencies = {
			"rafamadriz/friendly-snippets",
			{ "saghen/blink.indent", opts = {} },
			{ "saghen/blink.pairs", version = "*", dependencies = "saghen/blink.download", opts = {} },
		},
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
