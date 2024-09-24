return {
	"stevearc/conform.nvim",
	event = "VeryLazy",
	config = function()
		local conform = require("conform")
		local in_kilanka = function()
			if string.find(vim.fn.expand("%:p"), "kilanka") then
				return { "prettier", "biome-check", "biome", stop_after_first = true }
			end
			return { "biome-check", "biome", "prettier", stop_after_first = true }
		end
		conform.setup({
			notify_on_error = false,
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
			formatters_by_ft = {
				css = in_kilanka(),
				go = { "goimports", "golines", "gofumpt" },
				html = in_kilanka(),
				javascript = in_kilanka(),
				javascriptreact = in_kilanka(),
				json = in_kilanka(),
				lua = { "stylua" },
				typescript = in_kilanka(),
				typescriptreact = in_kilanka(),
			},
		})
	end,
}
