return {
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = { theme = "auto" },
			sections = { lualine_c = { { "filename", file_status = true, path = 1 } } },
			tabline = { lualine_a = { "buffers" } },
		},
	},
}
