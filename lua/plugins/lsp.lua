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
	dependencies = { "williamboman/mason-lspconfig.nvim", "neovim/nvim-lspconfig" },
	config = function()
		local lspconfig = require("lspconfig")
		local scope = function(name)
			return string.format(":Pick lsp scope='%s'<cr>", name)
		end
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("config-lsp-attach", { clear = true }),
			callback = function(event)
				local buffer = event.buf
				map("n", "gd", scope("definition"), { buffer = buffer, desc = "goto definition" })
				map("n", "gr", scope("references"), { buffer = buffer, desc = "goto references" })
				map("n", "gI", scope("implementation"), { buffer = buffer, desc = "goto implementation" })
				map("n", "<leader>gD", scope("type_definition"), { buffer = buffer, desc = "goto type definition" })
				map("n", "gD", scope("declaration"), { buffer = buffer, desc = "goto declaration" })
				map("n", "<leader>rn", vim.lsp.buf.rename, { buffer = buffer, desc = "rename" })
				map("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = buffer, desc = "LSP: code action" })
				map("n", "<leader>k", vim.diagnostic.open_float, { buffer = buffer, desc = "diagnostics" })
				map("n", "<leader>xx", ":Pick diagnostic<cr>", { buffer = buffer, desc = "all diagnostics" })
			end,
		})
		require("mason").setup()
		local mason_lspconfig = require("mason-lspconfig")
		mason_lspconfig.setup({ ensure_installed = vim.tbl_keys(servers) })
		mason_lspconfig.setup_handlers({
			function(server_name)
				local config = servers[server_name] or {}
				lspconfig[server_name].setup({
					capabilities = vim.lsp.protocol.make_client_capabilities(),
					filetypes = config.filetypes or {},
					flags = { debounce_text_changes = 150 },
					settings = config.settings or {},
					init_options = config.init_options or {},
				})
			end,
		})
	end,
}
