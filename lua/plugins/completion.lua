local M = { pairs = require("blink.pairs"), blink = require("blink.cmp") }

M.pairs.setup({})
M.blink.setup({
	signature = { enabled = true },
	fuzzy = { implementation = "lua" },
	appearance = { nerd_font_variant = "normal" },
	completion = { documentation = { auto_show = true } },
	sources = { default = { "lsp", "path", "snippets", "buffer" } },
	keymap = {
		preset = "enter",
		["<Tab>"] = { "select_next", "fallback" },
		["<S-Tab>"] = { "select_prev", "fallback" },
	},
})

return M
