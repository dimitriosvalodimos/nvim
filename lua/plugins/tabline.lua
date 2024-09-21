return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	opts = {
		options = {
			buffer_close_icon = "",
			close_command = "bdelete %d",
			close_icon = "",
			indicator = {
				style = "icon",
				icon = " ",
			},
			left_trunc_marker = "",
			modified_icon = "●",
			offsets = { { filetype = "NvimTree", text = "EXPLORER", text_align = "center" } },
			right_mouse_command = "bdelete! %d",
			right_trunc_marker = "",
			show_close_icon = false,
			show_tab_indicators = true,
		},
	},
}
