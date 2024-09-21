return {
	"stevearc/conform.nvim",
	opts = {
		notify_on_error = false,
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
		formatters_by_ft = {
			css = { "biome-check", "biome", "prettier", stop_after_first = true },
			go = { "goimports", "golines", "gofumpt" },
			html = { "biome-check", "biome", "prettier", stop_after_first = true },
			javascript = { "biome-check", "biome", "prettier", stop_after_first = true },
			javascriptreact = { "biome-check", "biome", "prettier", stop_after_first = true },
			json = { "biome-check", "biome", "prettier", stop_after_first = true },
			lua = { "stylua" },
			typescript = { "biome-check", "biome", "prettier", stop_after_first = true },
			typescriptreact = { "biome-check", "biome", "prettier", stop_after_first = true },
		},
	},
}
