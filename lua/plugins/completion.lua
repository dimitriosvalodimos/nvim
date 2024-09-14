return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"https://codeberg.org/FelipeLema/cmp-async-path",
		"ray-x/cmp-treesitter",
		"hrsh7th/cmp-nvim-lua",
		"ray-x/cmp-sql",
	},
	config = function()
		local kind_icons = {
			Text = "",
			Method = "󰆧",
			Function = "󰊕",
			Constructor = "",
			Field = "󰇽",
			Variable = "󰂡",
			Class = "󰠱",
			Interface = "",
			Module = "",
			Property = "󰜢",
			Unit = "",
			Value = "󰎠",
			Enum = "",
			Keyword = "󰌋",
			Snippet = "",
			Color = "󰏘",
			File = "󰈙",
			Reference = "",
			Folder = "󰉋",
			EnumMember = "",
			Constant = "󰏿",
			Struct = "",
			Event = "",
			Operator = "󰆕",
			TypeParameter = "󰅲",
		}

		local has_words_before = function()
			unpack = unpack or table.unpack
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		end

		local cmp = require("cmp")
		cmp.setup({
			snippet = {
				expand = function(args)
					vim.snippet.expand(args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			formatting = {
				format = function(entry, vim_item)
					vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
					vim_item.menu = ({
						nvim_lsp = "[lsp]",
						treesitter = "[ts]",
						nvim_lua = "[lua]",
						sql = "[sql]",
						buffer = "[buf]",
						async_path = "[path]",
					})[entry.source.name]
					return vim_item
				end,
			},

			mapping = cmp.mapping.preset.insert({
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<Tab>"] = function(fallback)
					if not cmp.select_next_item() then
						if vim.bo.buftype ~= "prompt" and has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end
				end,
				["<S-Tab>"] = function(fallback)
					if not cmp.select_prev_item() then
						if vim.bo.buftype ~= "prompt" and has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end
				end,
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "treesitter" },
				{ name = "nvim_lua" },
				{ name = "sql" },
				{ name = "buffer" },
				{ name = "async_path" },
				{ name = "nvim_lsp_signature_help" },
			}),
		})

		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			view = {
				entries = { name = "wildmenu", separator = "|" },
			},
			sources = {
				{ name = "buffer" },
			},
		})

		cmp.setup.cmdline(":", {
			view = {
				entries = { name = "wildmenu", separator = "|" },
			},
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "async_path" },
				{ name = "cmdline" },
			}),
			matching = { disallow_symbol_nonprefix_matching = false },
		})
	end,
}
