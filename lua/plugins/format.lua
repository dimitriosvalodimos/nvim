return {
	"stevearc/conform.nvim",
	opts = {
		format_on_save = { timeout_ms = 200, lsp_format = true, async = false },
		formatters_by_ft = {
			css = { "prettier", lsp_format = "fallback" },
			html = { "prettier", lsp_format = "fallback" },
			javascript = { "biome-check", "biome", "prettier", stop_after_first = true, lsp_format = "fallback" },
			javascriptreact = { "biome-check", "biome", "prettier", stop_after_first = true, lsp_format = "fallback" },
			json = { "biome-check", "biome", "prettier", stop_after_first = true, lsp_format = "fallback" },
			lua = { "stylua", lsp_format = "fallback" },
			rust = { "rustfmt", lsp_format = "fallback" },
			typescript = { "biome-check", "biome", "prettier", stop_after_first = true, lsp_format = "fallback" },
			typescriptreact = { "biome-check", "biome", "prettier", stop_after_first = true, lsp_format = "fallback" },
		},
	},
}
