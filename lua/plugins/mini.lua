require("mini.icons").setup()
require("mini.tabline").setup()
require("mini.statusline").setup()
require("mini.diff").setup()
require("mini.pairs").setup()
require("mini.extra").setup()
local pick_config = function()
	local h, w = vim.o.lines, vim.o.columns
	local width = w
	local height = math.floor(0.33 * h)
	return {
		anchor = "NW",
		border = "none",
		height = height,
		width = width,
		row = h - height,
		col = 0,
	}
end
require("mini.pick").setup({ window = { config = pick_config } })
require("mini.move").setup({
	mappings = {
		left = "<S-left>",
		right = "<S-right>",
		down = "<S-down>",
		up = "<S-up>",
		line_left = "<S-left>",
		line_right = "<S-right>",
		line_down = "<S-down>",
		line_up = "<S-up>",
	},
})
