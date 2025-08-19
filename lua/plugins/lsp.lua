local map = vim.keymap.set
return {
	"mason-org/mason.nvim",
	dependencies = {
		"saghen/blink.cmp",
		"ibhagwan/fzf-lua",
		"neovim/nvim-lspconfig",
		"zapling/mason-conform.nvim",
		"mason-org/mason-lspconfig.nvim",
	},
	config = function()
		local fzf = require("fzf-lua")
		fzf.register_ui_select()
		local capabilities = require("blink.cmp").get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())
		vim.lsp.config("*", { capabilities = capabilities })
		vim.diagnostic.config({ severity_sort = true, virtual_lines = false, virtual_text = true })
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = { "cssls", "html", "lua_ls", "ts_ls" },
			automatic_enable = true,
		})
		require("mason-conform").setup({})
		map("n", "gca", fzf.lsp_code_actions, {})
		map("n", "grr", fzf.lsp_references, {})
		map("n", "gd", fzf.lsp_definitions, {})
		map("n", "gri", fzf.lsp_implementations, {})
		map("n", "grt", fzf.lsp_typedefs, {})
		map("n", "gO", fzf.lsp_document_symbols, {})
	end,
}
