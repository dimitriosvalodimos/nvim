return {
	"williamboman/mason.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		"hrsh7th/cmp-nvim-lsp",
		"nvim-telescope/telescope.nvim",
		"pmizio/typescript-tools.nvim",
		"nvim-lua/plenary.nvim",
		{ "folke/trouble.nvim", opts = {} },
		{ "folke/neodev.nvim", opts = {} },
		{ "j-hui/fidget.nvim", opts = { progress = { ignore_done_already = true, ignore_empty_message = true } } },
		{
			"smjonas/inc-rename.nvim",
			config = function()
				require("inc_rename").setup()
			end,
		},
	},
	config = function()
		local servers = {
			cssls = { settings = {}, filetypes = { "css" } },
			cssmodules_ls = { settings = {}, filetypes = { "css" } },
			eslint = {
				settings = {},
				filetypes = { "css", "javascript", "typescript", "javascriptreact", "typescriptreact" },
			},
			emmet_ls = { settings = {}, filetypes = { "html", "javascriptreact", "typescriptreact" } },
			gopls = { settings = {}, filetypes = { "go", "gomod", "gosum" } },
			html = { settings = {}, filetypes = { "html" } },
			-- tsserver = {
			-- 	settings = {},
			-- 	filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
			-- },
			lua_ls = {
				settings = {
					Lua = {
						workspace = { checkThirdParty = false },
						telemetry = { enable = false },
						diagnostics = { disable = { "missing-fields" } },
						completion = {
							callSnippet = "Replace",
						},
					},
				},
				filetypes = { "lua" },
			},
			svelte = { settings = {}, filetypes = { "svelte" } },
			tailwindcss = { settings = {}, filetypes = { "javascriptreact", "typescriptreact", "svelte" } },
		}

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
		capabilities.textDocument.completion.completionItem.snippetSupport = true

		local function on_attach(_, bufnr)
			vim.api.nvim_create_autocmd("CursorHold", {
				buffer = bufnr,
				callback = function()
					local opts = {
						focusable = false,
						close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
						border = "rounded",
						source = "always",
						prefix = " ",
						scope = "cursor",
					}
					vim.diagnostic.open_float(nil, opts)
				end,
			})
		end

		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
			border = "single",
		})
		vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signatureHelp, {
			border = "single",
		})
		vim.diagnostic.config({
			virtual_text = { source = "if_many" },
			signs = true,
			underline = true,
			update_in_insert = true,
			severity_sort = true,
			float = { source = "if_many", border = "single" },
		})

		require("mason").setup({})
		require("mason-lspconfig").setup({ ensure_installed = vim.tbl_keys(servers) })
		require("mason-lspconfig").setup_handlers({
			function(server_name)
				require("lspconfig")[server_name].setup({
					on_attach = on_attach,
					capabilities = capabilities,
					settings = (servers[server_name] or {}).settings,
					filetypes = (servers[server_name] or {}).filetypes,
				})
			end,
		})

		require("typescript-tools").setup({
			on_attach = on_attach,
			capabilities = capabilities,
			filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
			settings = {
				separate_diagnostic_server = true,
				publish_diagnostic_on = "change",
				expose_as_code_action = { "all" },
				tsserver_path = nil,
				tsserver_plugins = { "@styled/typescript-styled-plugin" },
				tsserver_max_memory = "auto",
				tsserver_format_options = {},
				tsserver_file_preferences = {
					quotePreference = "auto",
					importModuleSpecifierEnding = "auto",
					jsxAttributeCompletionStyle = "auto",
					allowTextChangesInNewFiles = true,
					providePrefixAndSuffixTextForRename = true,
					allowRenameOfImportPath = true,
					includeAutomaticOptionalChainCompletions = true,
					provideRefactorNotApplicableReason = true,
					generateReturnInDocTemplate = true,
					includeCompletionsForImportStatements = true,
					includeCompletionsWithSnippetText = true,
					includeCompletionsWithClassMemberSnippets = true,
					includeCompletionsWithObjectLiteralMethodSnippets = true,
					useLabelDetailsInCompletionEntries = true,
					allowIncompleteCompletions = true,
					displayPartsForJSDoc = true,
					disableLineTextInReferences = true,
					includeInlayParameterNameHints = "none",
					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
					includeInlayFunctionParameterTypeHints = false,
					includeInlayVariableTypeHints = false,
					includeInlayVariableTypeHintsWhenTypeMatchesName = false,
					includeInlayPropertyDeclarationTypeHints = false,
					includeInlayFunctionLikeReturnTypeHints = false,
					includeInlayEnumMemberValueHints = false,
				},
				tsserver_locale = "en",
				complete_function_calls = true,
				include_completions_with_insert_text = true,
				code_lens = "all",
				disable_member_code_lens = true,
				jsx_close_tag = {
					enable = false,
					filetypes = { "javascriptreact", "typescriptreact" },
				},
			},
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
				local opts = { buffer = ev.buf }

				vim.keymap.set(
					"n",
					"gd",
					require("telescope.builtin").lsp_definitions,
					{ desc = "goto definition", buffer = ev.buf }
				)
				vim.keymap.set(
					"n",
					"gr",
					require("telescope.builtin").lsp_references,
					{ desc = "goto references", buffer = ev.buf }
				)
				vim.keymap.set(
					"n",
					"gI",
					require("telescope.builtin").lsp_implementations,
					{ desc = "goto implementation", buffer = ev.buf }
				)
				vim.keymap.set(
					"n",
					"<leader>D",
					require("telescope.builtin").lsp_type_definitions,
					{ desc = "type definition", buffer = ev.buf }
				)
				vim.keymap.set(
					"n",
					"<leader>ds",
					require("telescope.builtin").lsp_document_symbols,
					{ desc = "document symbols", buffer = ev.buf }
				)
				vim.keymap.set(
					"n",
					"<leader>ws",
					require("telescope.builtin").lsp_dynamic_workspace_symbols,
					{ desc = "workspace symbols", buffer = ev.buf }
				)
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				-- vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				-- vim.keymap.set("n", "<C-K>", vim.lsp.buf.signature_help, opts)
				vim.keymap.set("n", "<C-K>", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
				vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
				vim.keymap.set("n", "<leader>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, opts)
				vim.keymap.set("n", "<leader>rn", function()
					return ":IncRename " .. vim.fn.expand("<cword>")
				end, { buffer = ev.buf, expr = true })
				vim.keymap.set("n", "<leader>ca", function()
					vim.lsp.buf.code_action({ context = { only = { "quickfix", "refactor", "source" } } })
				end, { desc = "code action", buffer = ev.buf })
			end,
		})

		vim.keymap.set("n", "gR", function()
			require("trouble").toggle("lsp_references")
		end, { desc = "LSP references" })
		vim.keymap.set("n", "<leader>xx", function()
			require("trouble").toggle("workspace_diagnostics")
		end, { desc = "toggle diagnostics" })
	end,
}
