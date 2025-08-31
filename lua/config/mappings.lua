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
map("n", "<leader>ff", ":Pick files<cr>")
map("n", "<leader>fg", ":Pick grep_live<cr>")
map("n", "<leader>fb", ":Pick buffers<cr>")
map("n", "<leader>fr", ":Pick resume<cr>")
map("n", "<leader>fR", ":Pick registers<cr>")
map("n", "<leader>/", ":Pick buf_lines scope='current'<cr>")
map("n", "<leader>xx", ":Pick diagnostic<cr>")
map("n", "gca", vim.lsp.buf.code_action, { silent = true })
map("n", "grr", ":Pick lsp scope='references'<cr>", { silent = true })
map("n", "gd", ":Pick lsp scope='definition'<cr>", { silent = true })
map("n", "gri", ":Pick lsp scope='implementation'<cr>", { silent = true })
map("n", "grt", ":Pick lsp scope='type_definition'<cr>", { silent = true })
map("n", "gO", ":Pick lsp scope='document_symbol'<cr>", { silent = true })
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
