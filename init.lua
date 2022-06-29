local disabled_built_ins = {
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"gzip",
	"zip",
	"zipPlugin",
	"tar",
	"tarPlugin",
	"getscript",
	"getscriptPlugin",
	"vimball",
	"vimballPlugin",
	"2html_plugin",
	"logipat",
	"rrhelper",
	"spellfile_plugin",
	"matchit",
}
for _, plugin in pairs(disabled_built_ins) do
	vim.g["loaded_" .. plugin] = 1
end
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.opt.switchbuf = "usetab"
vim.opt.modeline = true
vim.opt.laststatus = 2
vim.opt.showtabline = 2
vim.opt.pumheight = 10
vim.opt.conceallevel = 0
vim.opt.showmode = false
vim.opt.colorcolumn = "+1"
vim.opt.startofline = false
vim.opt.breakindent = true
vim.opt.lazyredraw = true
vim.opt.hidden = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.wrap = false
vim.opt.timeoutlen = 300
vim.opt.signcolumn = "yes"
vim.opt.cmdheight = 1
-- vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.o.updatetime = 250
if vim.fn.exists("syntax_on") ~= 1 then
	vim.cmd([[syntax enable]])
end
vim.opt.ignorecase = true
vim.opt.clipboard = "unnamedplus"
vim.cmd([[set shortmess+=c]])
vim.cmd([[let g:python3_host_prog="~/.config/nvim/.venv/bin/python3"]])

vim.cmd([[packadd packer.nvim]])
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])
return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use({
		"catppuccin/nvim",
		as = "catppuccin",
		config = function()
			local catppuccin = require("catppuccin")
			catppuccin.setup({
				transparent_background = false,
				term_colors = true,
				styles = {
					comments = "italic",
					conditionals = "NONE",
					loops = "NONE",
					functions = "bold",
					keywords = "bold",
					strings = "NONE",
					variables = "NONE",
					numbers = "NONE",
					booleans = "NONE",
					properties = "NONE",
					types = "NONE",
					operators = "NONE",
				},
				integrations = {
					treesitter = true,
					native_lsp = {
						enabled = true,
						virtual_text = {
							errors = "italic",
							hints = "italic",
							warnings = "italic",
							information = "italic",
						},
						underlines = {
							errors = "underline",
							hints = "underline",
							warnings = "underline",
							information = "underline",
						},
					},
					coc_nvim = false,
					lsp_trouble = true,
					cmp = true,
					lsp_saga = false,
					gitgutter = false,
					gitsigns = true,
					telescope = true,
					nvimtree = {
						enabled = true,
						show_root = true,
						transparent_panel = true,
					},
					neotree = {
						enabled = false,
						show_root = false,
						transparent_panel = false,
					},
					which_key = true,
					indent_blankline = {
						enabled = true,
						colored_indent_levels = true,
					},
					dashboard = true,
					neogit = true,
					vim_sneak = false,
					fern = false,
					barbar = false,
					bufferline = true,
					markdown = false,
					lightspeed = false,
					ts_rainbow = true,
					hop = false,
					notify = true,
					telekasten = false,
					symbols_outline = true,
				},
			})
			vim.cmd([[colorscheme catppuccin]])
		end,
	})
	-- use({
	-- 	"luisiacc/gruvbox-baby",
	-- 	config = function()
	-- 		vim.g.gruvbox_baby_comment_style = "italic"
	-- 		vim.g.gruvbox_baby_keyword_style = "bold"
	-- 		vim.g.gruvbox_baby_function_style = "italic"
	-- 		vim.g.gruvbox_baby_variable_style = "NONE"
	-- 		vim.g.gruvbox_baby_telescope_theme = 1
	-- 		vim.cmd([[colorscheme gruvbox-baby]])
	-- 	end,
	-- })
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({
				disable_filetype = { "TelescopePrompt", "vim" },
			})
		end,
	})
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
			"petertriho/cmp-git",
			"onsails/lspkind.nvim",
			"windwp/nvim-autopairs",
		},
		config = function()
			local kind_icons = {
				Text = "",
				Method = "",
				Function = "",
				Constructor = "",
				Field = "",
				Variable = "",
				Class = "ﴯ",
				Interface = "",
				Module = "",
				Property = "ﰠ",
				Unit = "",
				Value = "",
				Enum = "",
				Keyword = "",
				Snippet = "",
				Color = "",
				File = "",
				Reference = "",
				Folder = "",
				EnumMember = "",
				Constant = "",
				Struct = "",
				Event = "",
				Operator = "",
				TypeParameter = "",
			}
			local has_words_before = function()
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			local feedkey = function(key, mode)
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
			end
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			local lspkind = require("lspkind")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
			cmp.setup({
				formatting = {
					-- format = lspkind.cmp_format(),
					format = function(_, vim_item)
						vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
						return vim_item
					end,
				},
				snippet = {
					expand = function(args)
						vim.fn["vsnip#anonymous"](args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif vim.fn["vsnip#available"](1) == 1 then
							feedkey("<Plug>(vsnip-expand-or-jump)", "")
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function()
						if cmp.visible() then
							cmp.select_prev_item()
						elseif vim.fn["vsnip#jumpable"](-1) == 1 then
							feedkey("<Plug>(vsnip-jump-prev)", "")
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "vsnip" },
				}, {
					{ name = "buffer" },
				}),
			})
			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources({
					{ name = "cmp_git" },
				}, {
					{ name = "buffer" },
				}),
			})
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
				view = {
					entries = { name = "wildmenu", seperator = "|" },
				},
			})
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
				view = {
					entries = { name = "wildmenu", seperator = "|" },
				},
			})
		end,
	})
	use({
		"neovim/nvim-lspconfig",
		requires = { "hrsh7th/nvim-cmp", "RRethy/vim-illuminate", "ray-x/lsp_signature.nvim" },
		config = function()
			local opts = { noremap = true, silent = true }
			vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
			vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
			local on_attach = function(client, bufnr)
				require("illuminate").on_attach(client)
				vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
				local bufopts = { noremap = true, silent = true, buffer = bufnr }
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
				vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
				vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
				vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
				vim.keymap.set("n", "<space>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, bufopts)
				vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
				vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
				vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
				vim.keymap.set("n", "<space>f", vim.lsp.buf.formatting, bufopts)
			end
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
			capabilities.textDocument.completion.completionItem.snippetSupport = true
			local lsp_flags = {
				debounce_text_changes = 150,
			}
			local servers = {
				"bashls",
				"cssls",
				"cssmodules_ls",
				"diagnosticls",
				"emmet_ls",
				"eslint",
				"graphql",
				"html",
				"jsonls",
				"prismals",
				"pyright",
				"rust_analyzer",
				"stylelint_lsp",
				"tailwindcss",
				"tsserver",
				"vimls",
				"yamlls",
			}
			require("lspconfig").sumneko_lua.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					Lua = {
						telemetry = { enable = false },
						runtime = {
							version = "LuaJIT",
							path = vim.split(package.path, ";"),
						},
						diagnostics = { globals = { "vim" } },
						workspace = {
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
							},
						},
					},
				},
			})
			for _, lsp in pairs(servers) do
				require("lspconfig")[lsp].setup({
					flags = lsp_flags,
					capabilities = capabilities,
					on_attach = on_attach,
				})
			end
			require("lsp_signature").setup({
				bind = true,
				handler_opts = {
					border = "rounded",
				},
				hint_prefix = "H: ",
			})
		end,
	})
	use({
		"kyazdani42/nvim-tree.lua",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("nvim-tree").setup({
				view = {
					adaptive_size = true,
					side = "right",
				},
			})
			vim.api.nvim_set_keymap("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { silent = true, noremap = true })
		end,
	})
	use({
		"nvim-treesitter/nvim-treesitter",
		requires = { "p00f/nvim-ts-rainbow" },
		run = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"bash",
					"c",
					"clojure",
					"cmake",
					"cpp",
					"css",
					"glsl",
					"go",
					"graphql",
					"html",
					"java",
					"javascript",
					"json",
					"julia",
					"kotlin",
					"latex",
					"llvm",
					"lua",
					"make",
					"ninja",
					"prisma",
					"python",
					"regex",
					"rust",
					"scss",
					"toml",
					"tsx",
					"typescript",
					"vim",
					"yaml",
				},
				highlight = {
					enable = true,
				},
				rainbow = {
					enable = true,
					extended_mode = true,
					max_file_lines = nil,
				},
			})
		end,
	})
	use({
		"folke/trouble.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("trouble").setup({})
			vim.api.nvim_set_keymap("n", "<leader>tx", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })
			vim.api.nvim_set_keymap(
				"n",
				"<leader>tw",
				"<cmd>Trouble workspace_diagnostics<cr>",
				{ silent = true, noremap = true }
			)
			vim.api.nvim_set_keymap(
				"n",
				"<leader>td",
				"<cmd>Trouble document_diagnostics<cr>",
				{ silent = true, noremap = true }
			)
			vim.api.nvim_set_keymap("n", "<leader>tl", "<cmd>Trouble loclist<cr>", { silent = true, noremap = true })
			vim.api.nvim_set_keymap("n", "<leader>tq", "<cmd>Trouble quickfix<cr>", { silent = true, noremap = true })
			vim.api.nvim_set_keymap("n", "gR", "<cmd>Trouble lsp_references<cr>", { silent = true, noremap = true })
		end,
	})
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	})
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("indent_blankline").setup({})
		end,
	})
	use({
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({
				layout = {
					align = "center",
				},
				plugins = {
					presets = {
						operators = false,
					},
				},
			})
		end,
	})
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", "arkav/lualine-lsp-progress" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "catppuccin", -- "gruvbox-baby",
				},
				sections = {
					lualine_c = {
						"lsp_progress",
					},
				},
			})
		end,
	})
	use({
		"TimUntersberger/neogit",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("neogit").setup()
		end,
	})
	use({
		"akinsho/bufferline.nvim",
		tag = "v2.*",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("bufferline").setup({})
		end,
	})
	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				"*",
			})
		end,
	})
	use({
		"akinsho/toggleterm.nvim",
		tag = "v1.*",
		config = function()
			require("toggleterm").setup({
				open_mapping = [[<c-t>]],
			})
		end,
	})
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})
	use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })
	use({
		"goolord/alpha-nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("alpha").setup(require("alpha.themes.startify").config)
		end,
	})
	use({
		"folke/todo-comments.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup({})
		end,
	})
	use({
		"simrat39/symbols-outline.nvim",
		config = function()
			require("symbols-outline").setup()
		end,
	})
	use({ "tversteeg/registers.nvim" })
	use({
		"kevinhwang91/nvim-hlslens",
		config = function()
			require("hlslens").setup({
				calm_down = true,
				nearest_only = true,
				nearest_float_when = "always",
			})
		end,
	})
	use({ "f-person/git-blame.nvim" })
	use({
		"mvllow/modes.nvim",
		config = function()
			require("modes").setup({
				line_opacity = 0.25,
			})
		end,
	})
	use({
		"matbme/JABS.nvim",
		config = function()
			local ui = vim.api.nvim_list_uis()[1]
			require("jabs").setup({
				col = ui.width,
				row = ui.height / 2,
			})
		end,
	})
	use({
		"fedepujol/move.nvim",
		config = function()
			vim.api.nvim_set_keymap("n", "<A-j>", ":MoveLine(1)<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "<A-k>", ":MoveLine(-1)<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("v", "<A-j>", ":MoveBlock(1)<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("v", "<A-k>", ":MoveBlock(-1)<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "<A-l>", ":MoveHChar(1)<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "<A-h>", ":MoveHChar(-1)<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("v", "<A-l>", ":MoveHBlock(1)<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("v", "<A-h>", ":MoveHBlock(-1)<CR>", { noremap = true, silent = true })
		end,
	})
	use({
		"nvim-telescope/telescope.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({})
			vim.cmd([[nnoremap <leader>tf <cmd>lua require('telescope.builtin').find_files()<cr>]])
			vim.cmd([[nnoremap <leader>tg <cmd>lua require('telescope.builtin').live_grep()<cr>]])
			vim.cmd([[nnoremap <leader>tb <cmd>lua require('telescope.builtin').buffers()<cr>]])
			vim.cmd([[nnoremap <leader>th <cmd>lua require('telescope.builtin').help_tags()<cr>]])
		end,
	})
	use({
		"m-demare/hlargs.nvim",
		requires = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("hlargs").setup()
		end,
	})
end)
