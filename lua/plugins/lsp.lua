local servers = { "cssls", "html", "lua_ls", "ts_ls" }
require("tiny-inline-diagnostic").setup({})
local lspconfig = require("lspconfig")
local chars = {}
for i = 32, 126 do
	table.insert(chars, string.char(i))
end
local on_attach = function(client, bufnr)
	if client:supports_method("textDocument/completion") then
		client.server_capabilities.completionProvider.triggerCharacters = chars
		vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
	end
end

vim.lsp.config("*", {
	capabilities = { textDocument = { completion = { completionItem = { snippetSupport = true } } } },
})
for _, server in ipairs(servers) do
	lspconfig[server].setup({ on_attach = on_attach })
end
vim.diagnostic.config({ severity_sort = true, virtual_lines = false, virtual_text = false })
vim.lsp.enable(servers)
