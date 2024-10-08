local g = vim.g
local opt = vim.opt

g.mapleader = " "
g.maplocalleader = ","

opt.background = "dark"
opt.backupcopy = "yes"
opt.breakindent = true
opt.clipboard = "unnamedplus"
opt.completeopt = { "menu", "menuone", "noselect", "noinsert", "popup" }
opt.conceallevel = 0 -- don't hide bold/italic markers
opt.confirm = true -- ask to save changes
opt.copyindent = true
opt.cursorline = true
opt.diffopt = vim.list_extend(vim.opt.diffopt:get(), { "algorithm:histogram", "linematch:60" })
opt.expandtab = true
opt.foldcolumn = "1"
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99 -- start with all code unfolded
opt.hlsearch = true
opt.ignorecase = true -- case insensitive searching
opt.inccommand = "nosplit" -- preview substitute
opt.infercase = true -- infer cases in keyword completion
opt.laststatus = 3 -- global statusline
opt.number = true
opt.numberwidth = 4
opt.preserveindent = true
opt.pumblend = 10 -- popup blend
opt.pumheight = 10 -- popup max height
opt.scrolloff = 5 -- vertical buffer area on scroll
opt.shiftround = true
opt.shiftwidth = 2
opt.sidescrolloff = 5 -- horizontal buffer area on scroll
opt.signcolumn = "yes" -- Always show the signcolumn
opt.smartcase = true
opt.smartindent = true
opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true
opt.tabstop = 2
opt.termguicolors = true
opt.timeoutlen = 300
opt.timeout = true
opt.title = true
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 300
opt.virtualedit = "block"
opt.wildmode = { "longest:full", "full" }
opt.wrap = false

if vim.fn.has("nvim-0.10") == 1 then
	opt.smoothscroll = true
	opt.foldmethod = "expr"
	opt.foldtext = ""
end

local disabled_plugins = {
	"2html_plugin",
	"tohtml",
	"getscript",
	"getscriptPlugin",
	"gzip",
	"logipat",
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"matchit",
	"tar",
	"tarPlugin",
	"rrhelper",
	"spellfile_plugin",
	"vimball",
	"vimballPlugin",
	"zip",
	"zipPlugin",
	"tutor",
	"rplugin",
	"syntax",
	"synmenu",
	"optwin",
	"compiler",
	"bugreport",
	"ftplugin",
}

for i = 1, #disabled_plugins do
	g["loaded_" .. disabled_plugins[i]] = true
end

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", {}),
	desc = "Highlight selection on yank",
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
	end,
})

local function map(mode, lhs, rhs, desc)
	vim.keymap.set(mode, lhs, rhs, { desc = desc })
end

map("n", "<c-h>", "<c-w><c-h>", "Move focus to the left window")
map("n", "<c-l>", "<c-w><c-l>", "Move focus to the right window")
map("n", "<c-j>", "<c-w><c-j>", "Move focus to the lower window")
map("n", "<c-k>", "<c-w><c-k>", "Move focus to the upper window")

map("i", "<c-u>", "<c-r>=trim(system('uuidgen'))<cr>", "insert uuid at cursor")
map("n", "<c-u>", "i<c-r>=trim(system('uuidgen'))<cr><esc>", "insert uuid at cursor")

map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", "move line up")
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", "move line down")

map("n", "<A-j>", ":m .+1<CR>==", "move line up")
map("n", "<A-k>", ":m .-2<CR>==", "move line down")

map("v", "<", "<gv", "dedent")
map("v", ">", ">gv", "indent")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ "nvim-tree/nvim-web-devicons", opts = {} },
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
		keys = { { "<leader>gs", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "toggle git blame" } },
	},
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				theme = "iceberg_dark",
				section_separators = "",
				component_separators = "",
			},
			tabline = {
				lualine_a = { "buffers" },
				lualine_z = { "tabs" },
			},
		},
	},
	{ "windwp/nvim-autopairs", event = "InsertEnter", opts = { disable_filetype = { "TelescopePrompt", "vim" } } },
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"windwp/nvim-autopairs",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp-signature-help",
		},
		config = function()
			local cmp = require("cmp")
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
			cmp.setup({
				snippet = {
					expand = function(args)
						vim.snippet.expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete({}),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "nvim_lua" },
					{ name = "buffer" },
				}),
			})
			cmp.setup.cmdline({ "/", "?" }, {
				view = {
					entries = { name = "wildmenu", separator = " | " },
				},
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})
			cmp.setup.cmdline(":", {
				view = {
					entries = { name = "wildmenu", separator = " | " },
				},
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
					{ name = "cmdline" },
				}),
				matching = { disallow_symbol_nonprefix_matching = false },
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.install").prefer_git = true
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"css",
					"diff",
					"html",
					"javascript",
					"jsdoc",
					"json",
					"lua",
					"luadoc",
					"markdown",
					"markdown_inline",
					"regex",
					"sql",
					"tsx",
					"typescript",
				},
				auto_install = true,
				highlight = { enable = true, additional_vim_regex_highlighting = false },
			})
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
			},
		},
		config = function()
			local telescope = require("telescope")
			telescope.setup({
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case", -- ignore_case, respect_case
					},
				},
			})
			telescope.load_extension("fzf")
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "find help" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "find buffer" })
			vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "find keymapping" })
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "find file" })
			vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "find current word" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "live grep" })
			vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "find diagnostics" })
			vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "resume search" })
			vim.keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = 'find recent files ("." for repeat)' })
			vim.keymap.set("n", "<leader>/", function()
				builtin.current_buffer_fuzzy_find(
					require("telescope.themes").get_dropdown({ winblend = 10, previewer = false })
				)
			end, { desc = "fuzzy find in buffer" })
			vim.keymap.set("n", "<leader>f/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "find in open files" })
		end,
	},
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"nvim-telescope/telescope.nvim",
			"aznhe21/actions-preview.nvim",
			"pmizio/typescript-tools.nvim",
			"neovim/nvim-lspconfig",
			"nvim-lua/plenary.nvim",
			"hrsh7th/cmp-nvim-lsp",
			{
				"j-hui/fidget.nvim",
				opts = {
					progress = { ignore_done_already = true, ignore_empty_message = true },
					notification = { window = { winblend = 0 } },
				},
			},
			{
				"zeioth/garbage-day.nvim",
				event = "VeryLazy",
				opts = { notifications = true },
			},
			{
				"smjonas/inc-rename.nvim",
				event = "VeryLazy",
				opts = {},
			},
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
						"jsonc",
						"typescript",
						"typescript.tsx",
						"typescriptreact",
						"css",
					},
				},
				cssls = { filetypes = { "css" }, settings = {} },
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
							assignVariableTypes = true,
							compositeLiteralFields = true,
							constantValues = true,
							functionTypeParameters = true,
							parameterNames = true,
							rangeVariableTypes = true,
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
				typst_lsp = {
					settings = { exportPdf = "onType" }, -- onSave
					filetypes = { "typst" },
				},
			}
			local capabilities = vim.tbl_deep_extend(
				"force",
				vim.lsp.protocol.make_client_capabilities(),
				require("cmp_nvim_lsp").default_capabilities(),
				{
					textDocument = {
						completion = {
							completionItem = {
								documentationFormat = { "markdown", "plaintext" },
								snippetSupport = true,
								preselectSupport = true,
								insertReplaceSupport = true,
								labelDetailsSupport = true,
								deprecatedSupport = true,
								commitCharactersSupport = true,
								tagSupport = { valueSet = { 1 } },
								resolveSupport = { properties = { "documentation", "detail", "additionalTextEdits" } },
							},
						},
					},
				}
			)
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
				end,
			})

			require("mason").setup()
			local mason_lspconfig = require("mason-lspconfig")
			mason_lspconfig.setup({ ensure_installed = vim.tbl_keys(servers) })
			mason_lspconfig.setup_handlers({
				function(server_name)
					if server_name == "ts_ls" then
						require("typescript-tools").setup({
							separate_diagnostic_server = true,
							publish_diagnostic_on = "insert_leave",
							expose_as_code_action = {
								"add_missing_imports",
								"remove_unused_imports",
								"organize_imports",
							}, -- "fix_all" | "add_missing_imports" | "remove_unused" | "remove_unused_imports" | "organize_imports" | "all"
							tsserver_path = nil,
							tsserver_plugins = { "@styled/typescript-styled-plugin" }, -- npm i -g @styled/typescript-styled-plugin typescript-styled-plugin
							tsserver_max_memory = "auto",
							tsserver_format_options = {}, -- https://github.com/microsoft/TypeScript/blob/v5.0.4/src/server/protocol.ts#L3418
							tsserver_file_preferences = {}, -- https://github.com/microsoft/TypeScript/blob/v5.0.4/src/server/protocol.ts#L3439
							tsserver_locale = "en",
							complete_function_calls = true,
							include_completions_with_insert_text = true,
							code_lens = "references_only", -- "off" | "all" | "implementations_only" | "references_only"
							disable_member_code_lens = true,
							jsx_close_tag = {
								enable = true,
								filetypes = { "javascriptreact", "typescriptreact" },
							},
						})
					else
						local config = servers[server_name] or {}
						lspconfig[server_name].setup({
							capabilities = capabilities,
							filetypes = config.filetypes or {},
							settings = config.settings or {},
							flags = { debounce_text_changes = 150 },
						})
					end
				end,
			})

			vim.diagnostic.config({
				float = float_config,
				severity_sort = true,
				signs = { linehl = { "DiagnosticErrorLn", "DiagnosticWarnLn", "DiagnosticInfoLn", "DiagnosticHintLn" } },
				underline = true,
				update_in_insert = false,
				virtual_text = false,
			})
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		opts = {},
		keys = {
			{ "<leader>XX", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{ "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
		},
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>ma", "<cmd>lua require('harpoon'):list():add()<cr>", desc = "Mark: add" },
			{ "<leader>m1", "<cmd>lua require('harpoon'):list():select(1)<cr>", desc = "Mark: Jump to 1" },
			{ "<leader>m2", "<cmd>lua require('harpoon'):list():select(2)<cr>", desc = "Mark: Jump to 2" },
			{ "<leader>m3", "<cmd>lua require('harpoon'):list():select(3)<cr>", desc = "Mark: Jump to 3" },
			{ "<leader>m4", "<cmd>lua require('harpoon'):list():select(4)<cr>", desc = "Mark: Jump to 4" },
			{ "<leader>m4", "<cmd>lua require('harpoon'):list():select(4)<cr>", desc = "Mark: Jump to 4" },
			{
				"<leader>ml",
				"<cmd>lua require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())<cr>",
				desc = "Mark: open list",
			},
			{ "<leader>mn", "<cmd>lua require('harpoon'):list():next()<cr>", desc = "Mark: Jump to next" },
			{ "<leader>mp", "<cmd>lua require('harpoon'):list():prev()<cr>", desc = "Mark: Jump to previous" },
			{ "<leader>mcc", "<cmd>lua require('harpoon'):list():clear()<cr>", desc = "Mark: clear list" },
		},
	},
	{
		"stevearc/oil.nvim",
		opts = {},
		keys = { { "-", "<cmd>Oil<cr>", desc = "open parent dir" } },
	},
	{
		"stevearc/conform.nvim",
		event = "VeryLazy",
		opts = {
			notify_on_error = false,
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
			formatters_by_ft = {
				css = { "biome-check", "biome", "prettier", stop_after_first = true },
				go = { "goimports", "golines", "gofumpt" },
				html = { "biome-check", "biome", "prettier", stop_after_first = true },
				javascript = { "biome-check", "biome", "prettier", stop_after_first = true },
				javascriptreact = { "biome-check", "biome", "prettier", stop_after_first = true },
				json = { "biome-check", "biome", "prettier", stop_after_first = true },
				lua = { "stylua" },
				typescript = { "biome-check", "biome", "prettier", stop_after_first = true },
				typescriptreact = { "biome-check", "biome", "prettier", stop_after_first = true },
			},
		},
	},
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
		ft = "typescript",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"jay-babu/mason-nvim-dap.nvim",
			"williamboman/mason.nvim",
			"mxsdev/nvim-dap-vscode-js",
		},
		config = function()
			require("mason").setup()
			require("mason-nvim-dap").setup({
				ensure_installed = {},
				automatic_setup = true,
				automatic_installation = true,
				handlers = {},
			})
			local dap = require("dap")
			local dapui = require("dapui")
			dap.listeners.before.attach.dapui_config = dapui.open
			-- function()
			-- 	dapui.open()
			-- end
			dap.listeners.before.launch.dapui_config = dapui.open
			-- function()
			-- 	dapui.open()
			-- end
			dap.listeners.before.event_terminated.dapui_config = dapui.close
			-- function()
			-- 	dapui.close()
			-- end
			dap.listeners.before.event_exited.dapui_config = dapui.close
			-- function()
			-- 	dapui.close()
			-- end
			vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })
			require("dap-vscode-js").setup({
				debugger_cmd = { "js-debug-adapter" },
				debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter",
				adapters = { "pwa-node" },
			})
			dap.configurations["typescript"] = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach",
					processId = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
				},
			}
			map("n", "<F2>", dap.close, "Debug: Close")
			map("n", "<F5>", dap.continue, "Debug: Start/Continue")
			map("n", "<F9>", dap.toggle_breakpoint, "Debug: Toggle breakpoint")
			map("n", "<F10>", dap.step_over, "Debug: Step Over")
			map("n", "<F11>", dap.step_into, "Debug: Step Into")
			map("n", "<S-F11>", dap.step_out, "Debug: Step Out")
		end,
	},
})

-- https://github.com/ChristianChiarulli/neovim-codicons
