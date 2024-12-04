return {
	{ "nvim-lualine/lualine.nvim", opts = { options = { theme = "auto" } } },
	{ "akinsho/bufferline.nvim", version = "*", opts = { options = { close_icon = "", buffer_close_icon = "" } } },
	{ "Bekaboo/dropbar.nvim", dependencies = { "nvim-telescope/telescope-fzf-native.nvim" } },
}
