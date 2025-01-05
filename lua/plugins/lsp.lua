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
	pylsp = { filetypes = { "python" }, settings = {} },
	rust_analyzer = { filetypes = { "rust" }, settings = {} },
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
		"saghen/blink.cmp",
		"ibhagwan/fzf-lua",
		"neovim/nvim-lspconfig",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		local lspconfig = require("lspconfig")
		local fzf = require("fzf-lua")
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("config-lsp-attach", { clear = true }),
			callback = function(event)
				local buffer = event.buf
				map("n", "gd", fzf.lsp_definitions, { buffer = buffer, desc = "goto definition" })
				map("n", "gr", function()
					fzf.lsp_references({ ignore_current_line = true })
				end, { buffer = buffer, desc = "goto reference" })
				map("n", "gI", fzf.lsp_implementations, { buffer = buffer, desc = "goto implementation" })
				map("n", "gD", fzf.lsp_typedefs, { buffer = buffer, desc = "goto type definition" })
				map("n", "<leader>xx", fzf.diagnostics_document, { buffer = buffer, desc = "goto diagnostics" })
				map("n", "<leader>XX", fzf.diagnostics_workspace, { buffer = buffer, desc = "goto diagnostics" })
				map("n", "<leader>gD", fzf.lsp_declarations, { buffer = buffer, desc = "goto declaration" })
				map("n", "<leader>gf", fzf.lsp_finder, { buffer = buffer, desc = "LSP: finder" })
				map("n", "<leader>rn", vim.lsp.buf.rename, { buffer = buffer, desc = "rename" })
				map("n", "<leader>ca", fzf.lsp_code_actions, { buffer = buffer, desc = "LSP: code action" })
				map("n", "<leader>k", vim.diagnostic.open_float, { buffer = buffer, desc = "diagnostics" })
			end,
		})
		require("mason").setup()
		local mason_lspconfig = require("mason-lspconfig")
		mason_lspconfig.setup({ ensure_installed = vim.tbl_keys(servers) })
		local capabilities = require("blink.cmp").get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())
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
