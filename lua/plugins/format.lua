return {
	{
		"stevearc/conform.nvim",
		event = "VeryLazy",
		opts = {
			format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
			formatters_by_ft = {
				css = { "prettier" },
				go = { "goimports", "golines", "gofumpt" },
				html = { "prettier" },
				javascript = { "biome-check", "biome", "prettier", stop_after_first = true },
				javascriptreact = { "biome-check", "biome", "prettier", stop_after_first = true },
				json = { "biome-check", "biome", "prettier", stop_after_first = true },
				lua = { "stylua" },
				typescript = { "biome-check", "biome", "prettier", stop_after_first = true },
				typescriptreact = { "biome-check", "biome", "prettier", stop_after_first = true },
			},
		},
	},
}
