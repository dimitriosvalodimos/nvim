return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
		"lewis6991/gitsigns.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("neogit").setup({})
		require("gitsigns").setup({
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			current_line_blame = true,
			current_line_blame_formatter = "<author>, <author_time:%d.%m.%Y> - <summary>",
			current_line_blame_opts = { virt_text = true, virt_text_pos = "right_align" },
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns
				vim.keymap.set({ "n", "v" }, "]c", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, desc = "Jump to next hunk" })
				vim.keymap.set({ "n", "v" }, "[c", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, desc = "Jump to previous hunk" })
				vim.keymap.set("v", "<leader>hs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "stage git hunk" })
				vim.keymap.set("v", "<leader>hr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "reset git hunk" })
				vim.keymap.set("n", "<leader>hs", gs.stage_hunk, { desc = "git stage hunk" })
				vim.keymap.set("n", "<leader>hr", gs.reset_hunk, { desc = "git reset hunk" })
				vim.keymap.set("n", "<leader>hS", gs.stage_buffer, { desc = "git Stage buffer" })
				vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, { desc = "undo stage hunk" })
				vim.keymap.set("n", "<leader>hR", gs.reset_buffer, { desc = "git Reset buffer" })
				vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { desc = "preview git hunk" })
				vim.keymap.set("n", "<leader>hb", function()
					gs.blame_line({ full = false })
				end, { desc = "git blame line" })
				vim.keymap.set("n", "<leader>hd", gs.diffthis, { desc = "git diff against index" })
				vim.keymap.set("n", "<leader>hD", function()
					gs.diffthis("~")
				end, { desc = "git diff against last commit" })
				vim.keymap.set("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "toggle git blame line" })
				vim.keymap.set("n", "<leader>td", gs.toggle_deleted, { desc = "toggle git show deleted" })
				vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "select git hunk" })
			end,
		})
	end,
}
