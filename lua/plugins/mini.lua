return {
	{
		"echasnovski/mini.nvim",
		version = false,
		config = function()
			require("mini.statusline").setup()
			require("mini.tabline").setup()
			require("mini.comment").setup()
			require("mini.ai").setup()
			require("mini.git").setup()
			require("mini.pairs").setup()

			local hipatterns = require("mini.hipatterns")
			hipatterns.setup({
				highlighters = {
					-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
					fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
					hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
					todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
					note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
				},
			})
		end,
	},
}
