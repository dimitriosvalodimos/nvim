return {
	"stevearc/conform.nvim",
	opts = {
		format_on_save = { lsp_format = true, async = false, stop_after_first = true },
		formatters_by_ft = {
			css = { "prettier" },
			html = { "prettier" },
			javascript = { "prettier" },
			javascriptreact = { "prettier" },
			json = { "prettier" },
			lua = { "stylua" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
		},
	},
}
