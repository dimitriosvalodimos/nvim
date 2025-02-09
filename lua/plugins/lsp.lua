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
	ts_ls = {},
}
return {
	"williamboman/mason.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		"williamboman/mason-lspconfig.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
	},
	config = function()
		map("i", "<TAB>", function()
			return vim.fn.pumvisible() == 1 and "<C-n>" or "<TAB>"
		end, { silent = true, expr = true })
		map("i", "<S-TAB>", function()
			return vim.fn.pumvisible() == 1 and "<C-p>" or "<S-TAB>"
		end, { silent = true, expr = true })
		map("i", "<Enter>", function()
			return vim.fn.pumvisible() == 1 and "<C-y>" or "<Enter>"
		end, { silent = true, expr = true })
		local lspconfig = require("lspconfig")
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("config-lsp-attach", { clear = true }),
			callback = function(event)
				local buffer = event.buf
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client ~= nil and client:supports_method("textDocument/completion") then
					vim.lsp.completion.enable(true, client.id, buffer, { autotrigger = true })
				end
				map("n", "gd", vim.lsp.buf.definition, { buffer = buffer, desc = "goto definition" })
				map("n", "gr", vim.lsp.buf.references, { buffer = buffer, desc = "goto reference" })
				map("n", "gI", vim.lsp.buf.implementation, { buffer = buffer, desc = "goto implementation" })
				map("n", "gD", vim.lsp.buf.type_definition, { buffer = buffer, desc = "goto type definition" })
				map("n", "<leader>gD", vim.lsp.buf.declaration, { buffer = buffer, desc = "goto declaration" })
				map("n", "<leader>rn", vim.lsp.buf.rename, { buffer = buffer, desc = "rename" })
				map("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = buffer, desc = "LSP: code action" })
				map("n", "<leader>k", vim.diagnostic.open_float, { buffer = buffer, desc = "diagnostics" })
				map("i", "<C-Space>", vim.lsp.completion.trigger, { silent = true })
			end,
		})
		require("mason").setup()
		local mason_lspconfig = require("mason-lspconfig")
		local auto_installs = {}
		for _, v in ipairs(vim.tbl_keys(servers)) do
			if v ~= "gleam" then
				table.insert(auto_installs, v)
			end
		end
		mason_lspconfig.setup({ ensure_installed = auto_installs })
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.completion.completionItem.snippetSupport = true
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
		vim.diagnostic.config({ severity_sort = true, virtual_text = { source = "if_many" } })
	end,
}
