local map = require("config.utils").map
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

local lsp_filetypes = {}
for _, config in pairs(servers) do
	for _, ft in ipairs(config.filetypes or {}) do
		table.insert(lsp_filetypes, ft)
	end
end

return {
	"williamboman/mason.nvim",
	ft = lsp_filetypes,
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"neovim/nvim-lspconfig",
		"nvim-telescope/telescope.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		local lspconfig = require("lspconfig")
		local builtin = require("telescope.builtin")
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("config-lsp-attach", { clear = true }),
			callback = function(event)
				local buffer = event.buf
				map("n", "gd", builtin.lsp_definitions, { buffer = buffer, desc = "goto definition" })
				map("n", "gr", builtin.lsp_references, { buffer = buffer, desc = "goto reference" })
				map("n", "gI", builtin.lsp_implementations, { buffer = buffer, desc = "goto implementation" })
				map("n", "gD", builtin.lsp_type_definitions, { buffer = buffer, desc = "goto type definition" })
				map("n", "<leader>xx", builtin.diagnostics, { buffer = buffer, desc = "goto diagnostics" })
				map("n", "<leader>gD", vim.lsp.buf.declaration, { buffer = buffer, desc = "goto declaration" })
				map("n", "<leader>rn", vim.lsp.buf.rename, { buffer = buffer, desc = "rename" })
				map("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = buffer, desc = "LSP: code action" })
				map("n", "<leader>k", vim.diagnostic.open_float, { buffer = buffer, desc = "diagnostics" })
			end,
		})
		require("mason").setup()
		local mason_lspconfig = require("mason-lspconfig")
		mason_lspconfig.setup({ ensure_installed = vim.tbl_keys(servers) })
		local capabilities = vim.tbl_deep_extend(
			"force",
			vim.lsp.protocol.make_client_capabilities(),
			require("cmp_nvim_lsp").default_capabilities()
		)
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
