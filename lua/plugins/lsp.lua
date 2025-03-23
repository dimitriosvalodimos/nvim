local map = require("config.utils").map
local snake = require("config.utils").snake
local servers = {
	cssls = {},
	html = {},
	lua_ls = {
		settings = {
			Lua = {
				completion = { callSnippet = "Replace" },
				diagnostics = { globals = { "vim" }, disable = { "missing-fields" } },
				runtime = { version = "LuaJIT" },
				telemetry = { enable = false },
				workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
			},
		},
	},
	rust_analyzer = {},
	ts_ls = {},
}
local handlers = {
	["textDocument/rename"] = { "<leader>rn", "rename" },
	["textDocument/definition"] = { "gd", "goto definiton" },
	["textDocument/references"] = { "gr", "goto reference" },
	["textDocument/declaration"] = { "gD", "goto declaration" },
	["textDocument/implementation"] = { "gI", "goto implementation" },
	["textDocument/codeAction"] = { "<leader>ca", "code action" },
	["textDocument/typeDefinition*"] = { "<leader>gD", "goto type definition" },
}
---@param client vim.lsp.Client
---@param buf integer
local register_lsp_handlers = function(client, buf)
	local lbuf = vim.lsp.buf
	for method, conf in pairs(handlers) do
		local func = method:gmatch("%w+/(%w+)")()
		if client:supports_method(method, buf) then
			map("n", conf[1], lbuf[snake(func)], { buffer = buf, desc = conf[2] })
		end
	end
	map("n", "<leader>xx", vim.diagnostic.setqflist, "show workspace diagnostics")
end
return {
	"williamboman/mason.nvim",
	dependencies = { "neovim/nvim-lspconfig" },
	config = function()
		local lspconfig = require("lspconfig")
		require("mason").setup()
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.completion.completionItem.snippetSupport = false
		capabilities.textDocument.semanticTokens.multilineTokenSupport = true
		vim.diagnostic.config({ severity_sort = true, virtual_text = { source = "if_many" } })
		for server, config in pairs(servers) do
			lspconfig[server].setup({
				capabilities = capabilities,
				flags = { debounce_text_changes = 150 },
				settings = config.settings or {},
				init_options = config.init_options or {},
			})
		end
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("config-lsp-attach", { clear = true }),
			callback = function(event)
				local buf = event.buf
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if not client then
					return
				end
				if client:supports_method("textDocument/completion", buf) then
					vim.lsp.completion.enable(true, client.id, buf, { autotrigger = true })
				end
				register_lsp_handlers(client, buf)
			end,
		})
	end,
}
