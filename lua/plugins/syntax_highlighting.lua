return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"nvim-treesitter/nvim-treesitter-context",
		"windwp/nvim-ts-autotag",
		"andymass/vim-matchup",
		"Wansmer/treesj",
		{ "m-demare/hlargs.nvim", opts = {} },
		{ "mizlan/iswap.nvim", opts = {} },
		{ "numToStr/Comment.nvim", opts = {} },
		{
			"drybalka/tree-climber.nvim",
			config = function()
				local opts = { noremap = true, silent = true }
				local config = { skip_comments = true, highlight = true, on_macro = true }

				local tc = require("tree-climber")
				vim.keymap.set({ "n", "v", "o" }, "H", function()
					tc.goto_parent(config)
				end, opts)
				vim.keymap.set({ "n", "v", "o" }, "L", function()
					tc.goto_child(config)
				end, opts)
				vim.keymap.set({ "n", "v", "o" }, "J", function()
					tc.goto_next(config)
				end, opts)
				vim.keymap.set({ "n", "v", "o" }, "K", function()
					tc.goto_prev(config)
				end, opts)
				vim.keymap.set({ "v", "o" }, "in", function()
					tc.select_node(config)
				end, opts)
				vim.keymap.set("n", "<c-k>", function()
					tc.swap_prev(config)
				end, opts)
				vim.keymap.set("n", "<c-j>", function()
					tc.swap_next(config)
				end, opts)
				vim.keymap.set("n", "<c-h>", function()
					tc.highlight_node(config)
				end, opts)
			end,
		},
	},
	config = function()
		vim.g.matchup_matchparen_offscreen = { method = "popup" }

		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"css",
				"diff",
				"gitignore",
				"go",
				"gomod",
				"gosum",
				"html",
				"javascript",
				"jsdoc",
				"json",
				"json5",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"query",
				"regex",
				"sql",
				"svelte",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
			},
			sync_install = false,
			auto_install = true,
			matchup = { enable = true },
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<c-space>",
					node_incremental = "<c-space>",
					scope_incremental = "<c-s>",
					node_decremental = "<M-space>",
				},
			},
			autotag = {
				enable = true,
				enable_rename = true,
				enable_close = true,
				enable_close_on_slash = true,
			},
			textobjects = {
				lsp_interop = {
					enable = true,
					border = "none",
					floating_preview_opts = {},
					peek_definition_code = {
						["<leader>df"] = "@function.outer",
						["<leader>dF"] = "@class.outer",
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]m"] = "@function.outer",
						["]]"] = "@class.outer",
					},
					goto_next_end = {
						["]M"] = "@function.outer",
						["]["] = "@class.outer",
					},
					goto_previous_start = {
						["[m"] = "@function.outer",
						["[["] = "@class.outer",
					},
					goto_previous_end = {
						["[M"] = "@function.outer",
						["[]"] = "@class.outer",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>a"] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>A"] = "@parameter.inner",
					},
				},
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
			},
		})

		require("treesj").setup({})
		vim.keymap.set("n", "<leader>m", require("treesj").toggle)
		vim.keymap.set("n", "<leader>M", function()
			require("treesj").toggle({ split = { recursive = true } })
		end)

		require("treesitter-context").setup({
			enable = true,
			max_lines = 8,
			min_window_height = 0,
			line_numbers = true,
			multiline_threshold = 1,
			trim_scope = "outer",
			mode = "topline",
			separator = nil,
			zindex = 20,
		})
	end,
}
