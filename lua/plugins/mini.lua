return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
		local drawer = function()
			local floor, width, height = math.floor, vim.o.columns, vim.o.lines
			local half_height = floor(0.5 * height)
			return {
				anchor = "NW",
				width = width,
				height = half_height,
				row = height - half_height,
				col = 0,
			}
		end
		require("mini.ai").setup()
		require("mini.comment").setup()
		require("mini.extra").setup()
		require("mini.git").setup()
		require("mini.icons").setup()
		require("mini.move").setup()
		require("mini.pick").setup({ window = { config = drawer } })
		require("mini.statusline").setup()
		require("mini.tabline").setup()
		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniFilesWindowUpdate",
			callback = function(args)
				local config = vim.api.nvim_win_get_config(args.data.win_id)
				config.height = vim.o.lines
				config.width = vim.o.columns
				vim.api.nvim_win_set_config(args.data.win_id, config)
			end,
		})
	end,
}
