return {
	"stevearc/conform.nvim",
	opts = {
		format_on_save = { timeout_ms = 200, lsp_format = true, async = false },
		formatters_by_ft = {
			css = { "prettier" },
			html = { "prettier" },
			javascript = { "biome-check", "biome", "prettier", stop_after_first = true },
			javascriptreact = { "biome-check", "biome", "prettier", stop_after_first = true },
			json = { "biome-check", "biome", "prettier", stop_after_first = true },
			lua = { "stylua" },
			typescript = { "biome-check", "biome", "prettier", stop_after_first = true },
			typescriptreact = { "biome-check", "biome", "prettier", stop_after_first = true },
		},
	},
}
