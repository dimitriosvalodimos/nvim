return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = "VeryLazy",
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup({})
		local function map(lhs, rhs, desc)
			vim.keymap.set("n", lhs, rhs, { desc = desc })
		end
		map("<leader>ma", function()
			harpoon:list():add()
		end, "MARK: add")
		map("<leader>m1", function()
			harpoon:list():select(1)
		end, "MARK: Jump to 1")
		map("<leader>m2", function()
			harpoon:list():select(2)
		end, "MARK: Jump to 2")
		map("<leader>m3", function()
			harpoon:list():select(3)
		end, "MARK: Jump to 3")
		map("<leader>m4", function()
			harpoon:list():select(4)
		end, "MARK: Jump to 4")
		map("<leader>ml", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, "MARK: list")
		map("<leader>mn", function()
			harpoon:list():next()
		end, "MARK: Jumo to next")
		map("<leader>mp", function()
			harpoon:list():prev()
		end, "MARK: Jumo to previous")
		map("<leader>mcc", function()
			harpoon:list():clear()
		end, "MARK: clear list")
	end,
}
