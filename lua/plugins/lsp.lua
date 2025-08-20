local map = vim.keymap.set
return {
	{
		"mason-org/mason.nvim",
		dependencies = {
			"saghen/blink.cmp",
			"neovim/nvim-lspconfig",
			"zapling/mason-conform.nvim",
			"mason-org/mason-lspconfig.nvim",
			{
				"pmizio/typescript-tools.nvim",
				dependencies = { "nvim-lua/plenary.nvim" },
				ft = { "ts", "tsx", "js", "jsx", "json", "jsonc", "json5" },
				-- npm i -g @styled/typescript-styled-plugin typescript-styled-plugin
				opts = {
					settings = {
						complete_function_calls = true,
						expose_as_code_action = { "all" },
						tsserver_plugins = { "@styled/typescript-styled-plugin" },
						jsx_close_tag = { enable = true, filetypes = { "javascriptreact", "typescriptreact" } },
					},
				},
			},
		},
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())
			vim.lsp.config("*", { capabilities = capabilities })
			vim.diagnostic.config({ severity_sort = true, virtual_lines = false, virtual_text = true })
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "cssls", "html", "lua_ls" },
				automatic_enable = true,
			})
			require("mason-conform").setup({})
			map("n", "gca", ":FzfLua lsp_code_actions<cr>", {})
			map("n", "grr", ":FzfLua lsp_references<cr>", {})
			map("n", "gd", ":FzfLua lsp_definitions<cr>", {})
			map("n", "gri", ":FzfLua lsp_implementations<cr>", {})
			map("n", "grt", ":FzfLua lsp_typedefs<cr>", {})
			map("n", "gO", ":FzfLua lsp_document_symbols<cr>", {})
		end,
	},
}
