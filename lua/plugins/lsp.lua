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
	ols = {
		init_options = {
			checker_args = "-strict-style",
			collections = { { name = "shared", path = vim.fn.expand("$HOME/odin-lib") } },
		},
	},
	ts_ls = {},
}
return {
	"williamboman/mason.nvim",
	dependencies = {
		"saghen/blink.cmp",
		"neovim/nvim-lspconfig",
		"williamboman/mason-lspconfig.nvim",
		"folke/snacks.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
	},
	config = function()
		local lspconfig = require("lspconfig")
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("config-lsp-attach", { clear = true }),
			callback = function(event)
				local buffer = event.buf
				local picker = require("snacks").picker
				map("n", "gd", picker.lsp_definitions, { buffer = buffer, desc = "goto definition" })
				map("n", "gr", picker.lsp_references, { buffer = buffer, desc = "goto reference" })
				map("n", "gI", picker.lsp_implementations, { buffer = buffer, desc = "goto implementation" })
				map("n", "gD", picker.lsp_type_definitions, { buffer = buffer, desc = "goto type definition" })
				map("n", "<leader>gD", picker.lsp_declarations, { buffer = buffer, desc = "goto declaration" })
				map("n", "<leader>rn", vim.lsp.buf.rename, { buffer = buffer, desc = "rename" })
				map("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = buffer, desc = "LSP: code action" })
				map("n", "<leader>k", picker.diagnostics, { buffer = buffer, desc = "diagnostics" })
				map("n", "<leader>K", picker.diagnostics_buffer, { buffer = buffer, desc = "buffer diagnostics" })
			end,
		})
		require("mason").setup()
		local mason_lspconfig = require("mason-lspconfig")
		mason_lspconfig.setup({ ensure_installed = vim.tbl_keys(servers) })
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		require("blink.cmp").get_lsp_capabilities(capabilities)
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
