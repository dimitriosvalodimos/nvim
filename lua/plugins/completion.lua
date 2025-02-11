return {
	"saghen/blink.cmp",
	version = "*",
	opts = {
		keymap = {
			preset = "enter",
			["<S-TAB>"] = { "select_prev", "fallback" },
			["<TAB>"] = { "select_next", "fallback" },
		},
		appearance = { use_nvim_cmp_as_default = true },
		sources = { default = { "lsp", "path", "buffer" } },
		completion = {
			documentation = { auto_show = true },
			menu = {
				auto_show = function(ctx)
					return ctx.mode ~= "cmdline"
				end,
				draw = { treesitter = { "lsp" } },
			},
		},
		signature = { enabled = true },
	},
}
