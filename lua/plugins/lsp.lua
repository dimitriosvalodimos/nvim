return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"nvim-telescope/telescope.nvim",
		"aznhe21/actions-preview.nvim",
		"neovim/nvim-lspconfig",
		"nvim-lua/plenary.nvim",
		"hrsh7th/cmp-nvim-lsp",
		{ "j-hui/fidget.nvim", opts = { progress = { ignore_done_already = false, ignore_empty_message = false } } },
		{ "zeioth/garbage-day.nvim", event = "VeryLazy", opts = { notifications = true } },
		{ "smjonas/inc-rename.nvim", event = "VeryLazy", opts = {} },
		{ "VidocqH/lsp-lens.nvim", event = "VeryLazy", opts = {} },
	},
	config = function()
		local inlayHints = {
			includeInlayParameterNameHints = "all",
			includeInlayParameterNameHintsWhenArgumentMatchesName = false,
			includeInlayFunctionParameterTypeHints = true,
			includeInlayVariableTypeHints = true,
			includeInlayVariableTypeHintsWhenTypeMatchesName = false,
			includeInlayPropertyDeclarationTypeHints = true,
			includeInlayFunctionLikeReturnTypeHints = true,
			includeInlayEnumMemberValueHints = true,
		}
		local servers = {
			biome = {
				filetypes = {
					"javascript",
					"javascriptreact",
					"json",
					"typescript",
					"typescript.tsx",
					"typescriptreact",
					"css",
				},
				settings = {},
			},
			cssls = { filetypes = { "css" }, settings = {} },
			css_variables = { filetypes = { "css" }, settings = {} },
			emmet_ls = {
				filetypes = { "css", "html", "javascriptreact", "svelte", "typescriptreact" },
				settings = {},
			},
			eslint = {
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
					"svelte",
				},
				settings = {},
			},
			gopls = {
				filetypes = { "go", "gomod", "gowork", "gotmpl" },
				settings = {
					hints = {
						rangeVariableTypes = true,
						parameterNames = true,
						constantValues = true,
						assignVariableTypes = true,
						compositeLiteralFields = true,
						compositeLiteralTypes = true,
						functionTypeParameters = true,
					},
				},
			},
			html = { filetypes = { "html", "templ" }, settings = {} },
			lua_ls = {
				filetypes = { "lua" },
				settings = {
					Lua = {
						hint = { enable = true },
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
				settings = {
					typescript = { inlayHints = inlayHints },
					javascript = { inlayHints = inlayHints },
				},
			},
		}
		local capabilities = vim.tbl_deep_extend(
			"force",
			vim.lsp.protocol.make_client_capabilities(),
			require("cmp_nvim_lsp").default_capabilities()
		)
		capabilities.textDocument.completion.completionItem.snippetSupport = true
		local lspconfig = require("lspconfig")
		local float_config = {
			header = "",
			border = "single",
			source = "if_many",
			severity_sort = true,
		}
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("config-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end
				map("gd", require("telescope.builtin").lsp_definitions, "goto definition")
				map("gr", require("telescope.builtin").lsp_references, "goto references")
				map("gI", require("telescope.builtin").lsp_implementations, "goto implementation")
				map("<leader>D", require("telescope.builtin").lsp_type_definitions, "goto type definition")
				map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "document symbols")
				map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "workspace symbols")
				map("gD", vim.lsp.buf.declaration, "goto declaration")
				vim.keymap.set("n", "<leader>rn", function()
					return ":IncRename " .. vim.fn.expand("<cword>")
				end, { expr = true, desc = "LSP: rename" })
				vim.keymap.set(
					{ "v", "n" },
					"<leader>ca",
					require("actions-preview").code_actions,
					{ buffer = event.buf, desc = "LSP: code action" }
				)
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
				if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
					local highlight_augroup = vim.api.nvim_create_augroup("config-lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = function()
							vim.lsp.buf.document_highlight()
							local config = float_config
							config = vim.tbl_deep_extend("force", config, {
								focusable = false,
								close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
								scope = "cursor",
							})
							vim.diagnostic.open_float(nil, config)
						end,
					})
					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})
					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("config-lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "config-lsp-highlight", buffer = event2.buf })
						end,
					})
				end
				if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
					map("<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
					end, "toggle inlay hints")
				end
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
					settings = config.settings or {},
				})
			end,
		})

		vim.diagnostic.config({
			virtual_text = {
				source = "if_many",
				linehl = { "DiagnosticErrorLn", "DiagnosticWarnLn", "DiagnosticInfoLn", "DiagnosticHintLn" },
			},
			signs = {
				linehl = { "DiagnosticErrorLn", "DiagnosticWarnLn", "DiagnosticInfoLn", "DiagnosticHintLn" },
			},
			underline = true,
			update_in_insert = false,
			severity_sort = true,
			float = float_config,
		})
	end,
}
