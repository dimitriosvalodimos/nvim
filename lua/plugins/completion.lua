return {
	{
		"windwp/nvim-autopairs",
		opts = { enable_check_bracket_line = false, disable_filetype = { "TelescopePrompt", "spectre_panel", "vim" } },
	},
	{
		"saghen/blink.cmp",
		lazy = false,
		version = "v0.*",
		opts = {
			keymap = { preset = "super-tab" }, -- default, super-tab, enter
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "normal", -- mono, normal
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				cmdline = {}, -- optionally disable cmdline completions
			},
			signature = { enabled = true },
		},
	},
}
