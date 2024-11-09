local servers = {
	cssls = { filetypes = { "css" }, settings = {} },
	gopls = { filetypes = { "go", "gomod", "gowork", "gotmpl" }, settings = {} },
	html = { filetypes = { "html" }, settings = {} },
	lua_ls = {
		filetypes = { "lua" },
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
	ts_ls = {
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
		},
		init_options = { hostInfo = "neovim" },
	},
}
local server_names = vim.tbl_keys(servers)
local lsp_filetypes = {}
for _, server in ipairs(server_names) do
	for _, ft in ipairs(servers[server].filetypes) do
		table.insert(lsp_filetypes, ft)
	end
end

return {
	"williamboman/mason.nvim",
	ft = lsp_filetypes,
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"nvim-telescope/telescope.nvim",
		"neovim/nvim-lspconfig",
		"nvim-lua/plenary.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		local capabilities = vim.tbl_deep_extend(
			"force",
			vim.lsp.protocol.make_client_capabilities(),
			require("cmp_nvim_lsp").default_capabilities()
		)
		local lspconfig = require("lspconfig")
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("config-lsp-attach", { clear = true }),
			callback = function(event)
				local buffer = event.buf
				local builtin = require("telescope.builtin")
				vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = buffer, desc = "goto definition" })
				vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = buffer, desc = "goto references" })
				vim.keymap.set(
					"n",
					"gI",
					builtin.lsp_implementations,
					{ buffer = buffer, desc = "goto implementation" }
				)
				vim.keymap.set(
					"n",
					"<leader>gD",
					builtin.lsp_type_definitions,
					{ buffer = buffer, desc = "goto type definition" }
				)
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = buffer, desc = "goto declaration" })
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = buffer, desc = "rename" })
				vim.keymap.set(
					"n",
					"<leader>ca",
					vim.lsp.buf.code_action,
					{ buffer = buffer, desc = "LSP: code action" }
				)
				vim.keymap.set("n", "<leader>k", vim.diagnostic.open_float, { buffer = buffer, desc = "open float" })
			end,
		})
		require("mason").setup()
		local mason_lspconfig = require("mason-lspconfig")
		mason_lspconfig.setup({ ensure_installed = vim.tbl_keys(servers) })
		mason_lspconfig.setup_handlers({
			function(server_name)
				local config = servers[server_name] or {}
				lspconfig[server_name].setup({
					capabilities = capabilities,
					filetypes = config.filetypes or {},
					flags = { debounce_text_changes = 150 },
					settings = config.settings or {},
					init_options = config.init_options or {},
				})
			end,
		})
	end,
}
