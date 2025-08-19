vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("config_highlight_yank", { clear = true }),
	callback = function()
		(vim.hl or vim.highlight).on_yank()
	end,
})
