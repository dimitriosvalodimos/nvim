local map = require("config.utils").map
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
return {
	"williamboman/mason.nvim",
	dependencies = { "ibhagwan/fzf-lua", "neovim/nvim-lspconfig", "williamboman/mason-lspconfig.nvim" },
	config = function()
		local lspconfig = require("lspconfig")
		local fzf = require("fzf-lua")
		require("mason").setup()
		local mason_lspconfig = require("mason-lspconfig")
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.completion.completionItem.snippetSupport = true
		vim.diagnostic.config({ severity_sort = true, virtual_text = { source = "if_many" } })
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("config-lsp-attach", { clear = true }),
			callback = function(event)
				local buffer = event.buf
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				local methods = vim.lsp.protocol.Methods
				if client and client:supports_method(methods.textDocument_completion, buffer) then
					vim.lsp.completion.enable(true, client.id, buffer, { autotrigger = true })
				end
				map("n", "gd", fzf.lsp_definitions, { buffer = buffer, desc = "goto definition" })
				map("n", "gr", fzf.lsp_references, { buffer = buffer, desc = "goto reference" })
				map("n", "gI", fzf.lsp_implementations, { buffer = buffer, desc = "goto implementation" })
				map("n", "gD", fzf.lsp_typedefs, { buffer = buffer, desc = "goto type definition" })
				map("n", "<leader>gD", fzf.lsp_declarations, { buffer = buffer, desc = "goto declaration" })
				map("n", "<leader>ws", fzf.lsp_live_workspace_symbols, { buffer = buffer, desc = "goto symbols" })
				map("n", "<leader>gf", fzf.lsp_finder, { buffer = buffer, desc = "LSP: finder" })
				map("n", "<leader>rn", vim.lsp.buf.rename, { buffer = buffer, desc = "rename" })
				map("n", "<leader>ca", fzf.lsp_code_actions, { buffer = buffer, desc = "LSP: code action" })
				map("n", "<leader>xx", fzf.diagnostics_document, { buffer = buffer, desc = "goto diagnostics" })
				map("n", "<leader>XX", fzf.diagnostics_workspace, { buffer = buffer, desc = "goto diagnostics" })
			end,
		})
		mason_lspconfig.setup({ ensure_installed = vim.tbl_keys(servers) })
		mason_lspconfig.setup_handlers({
			function(server_name)
				local config = servers[server_name] or {}
				lspconfig[server_name].setup({
					capabilities = capabilities,
					flags = { debounce_text_changes = 150 },
					settings = config.settings or {},
					init_options = config.init_options or {},
				})
			end,
		})
	end,
}
