local wrap = function(fmts)
	return { unpack(fmts), stop_after_first = true, lsp_format = "fallback" }
end
return {
	"stevearc/conform.nvim",
	opts = {
		format_on_save = { lsp_format = true, async = false },
		formatters_by_ft = {
			css = wrap({ "prettier" }),
			html = wrap({ "prettier" }),
			javascript = wrap({ "biome-check", "biome", "prettier" }),
			javascriptreact = wrap({ "biome-check", "biome", "prettier" }),
			json = wrap({ "biome-check", "biome", "prettier" }),
			lua = wrap({ "stylua" }),
			rust = wrap({ "rustfmt" }),
			typescript = wrap({ "biome-check", "biome", "prettier" }),
			typescriptreact = wrap({ "biome-check", "biome", "prettier" }),
		},
	},
}
