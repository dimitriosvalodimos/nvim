local map = vim.keymap.set
local is_visible = function()
	return vim.fn.pumvisible() == 1
end
map("i", "<A-u>", "<c-r>=trim(system('uuidgen'))<cr>")
map("n", "<A-u>", "i<c-r>=trim(system('uuidgen'))<cr><esc>")
map("n", "K", vim.lsp.buf.hover)
map("n", "<leader>k", vim.diagnostic.open_float)
map("i", "<C-b>", "<ESC>^i")
map("i", "<C-e>", "<End>")
map("n", "<Esc>", "<cmd>noh<CR>")
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>")
map("n", "-", ":Oil<cr>")
map("i", "<cr>", function()
	if is_visible() then
		return "<C-y>"
	else
		return "<cr>"
	end
end, { expr = true, silent = true })
map("i", "<C-Space>", function()
	if next(vim.lsp.get_clients({ bufnr = 0 })) then
		vim.lsp.completion.get()
	end
end, { expr = true, silent = true })
map("i", "<Esc>", function()
	if is_visible() then
		return "<C-e><Esc>"
	else
		return "<Esc>"
	end
end, { expr = true, silent = true })
map("i", "<Tab>", function()
	if is_visible() then
		return "<C-n>"
	else
		return "<Tab>"
	end
end, { expr = true, silent = true })
map("i", "<S-Tab>", function()
	if is_visible() then
		return "<C-p>"
	else
		return "<S-Tab>"
	end
end, { expr = true, silent = true })
