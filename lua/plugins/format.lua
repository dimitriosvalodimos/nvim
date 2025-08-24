local prettier_or_biome = function(bufnr)
	local biome = require("conform").get_formatter_info("biome", bufnr)
	if biome.available then
		return { "biome-check", "biome-organize-imports", stop_after_first = false }
	else
		return { "prettier" }
	end
end

return {
	"stevearc/conform.nvim",
	opts = {
		format_on_save = { lsp_format = true, async = false, stop_after_first = true },
		formatters_by_ft = {
			css = prettier_or_biome,
			html = prettier_or_biome,
			javascript = prettier_or_biome,
			javascriptreact = prettier_or_biome,
			json = prettier_or_biome,
			lua = { "stylua" },
			typescript = prettier_or_biome,
			typescriptreact = prettier_or_biome,
		},
	},
}
