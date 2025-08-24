local map = vim.keymap.set
return {
	{
		"mason-org/mason.nvim",
		dependencies = {
			"saghen/blink.cmp",
			"neovim/nvim-lspconfig",
			"mason-org/mason-lspconfig.nvim",
			{
				"pmizio/typescript-tools.nvim",
				dependencies = { "nvim-lua/plenary.nvim" },
				ft = { "ts", "tsx", "js", "jsx", "json", "jsonc", "json5" },
				-- npm i -g @styled/typescript-styled-plugin typescript-styled-plugin
				opts = {
					settings = {
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
			map("n", "gca", ":FzfLua lsp_code_actions<cr>", { silent = true })
			map("n", "grr", ":FzfLua lsp_references<cr>", { silent = true })
			map("n", "gd", ":FzfLua lsp_definitions<cr>", { silent = true })
			map("n", "gri", ":FzfLua lsp_implementations<cr>", { silent = true })
			map("n", "grt", ":FzfLua lsp_typedefs<cr>", { silent = true })
			map("n", "gO", ":FzfLua lsp_document_symbols<cr>", { silent = true })
		end,
	},
}
