return {
	{
		"saghen/blink.cmp",
		lazy = false,
		version = "v0.*",
		opts = {
			keymap = { preset = "enter" }, -- default, super-tab, enter
			appearance = {
				use_nvim_cmp_as_default = true,
				-- nerd_font_variant = "normal", -- mono, normal
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				cmdline = {},
			},
			signature = { enabled = true },
		},
	},
}
