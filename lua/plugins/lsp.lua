local servers = { "cssls", "html", "lua_ls", "ts_ls" }
local lspconfig = require("lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
vim.lsp.config("*", { capabilities = capabilities })
for _, server in ipairs(servers) do
	lspconfig[server].setup({})
end
vim.diagnostic.config({ severity_sort = true, virtual_lines = false, virtual_text = { virt_text_pos = "right_align" } })
vim.lsp.enable(servers)
