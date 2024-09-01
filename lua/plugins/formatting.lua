return {
	"stevearc/conform.nvim",
	opts = {
		notify_on_error = false,
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
		formatters_by_ft = {
			css = { "prettier", "biome", stop_after_first = true },
			go = { "goimports", "golines", "gofumpt" },
			html = { "prettier", "biome", stop_after_first = true },
			javascript = { "prettier", "biome", stop_after_first = true },
			javascriptreact = { "prettier", "biome", stop_after_first = true },
			json = { "prettier", "biome", stop_after_first = true },
			lua = { "stylua" },
			typescript = { "prettier", "biome", stop_after_first = true },
			typescriptreact = { "prettier", "biome", stop_after_first = true },
		},
	},
}
