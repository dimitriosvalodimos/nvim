local map = require("config.utils").map
local function feedkeys(keys)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), "n", true)
end
local function pumvisible()
	return tonumber(vim.fn.pumvisible()) ~= 0
end
map("i", "<CR>", function()
	return pumvisible() and "<C-y>" or "<cr>"
end, { expr = true })
map("i", "<Esc>", function()
	return pumvisible() and "<C-e>" or "<Esc>"
end, { expr = true })
map("i", "<C-Space>", function()
	return not pumvisible() and vim.lsp.completion.trigger()
end, "trigger completion")
map("i", "<C-u>", "<C-x><C-n>", { desc = "Buffer completions" }) -- buffer completion
-- Use <Tab> to navigate between snippet tabstops, or select the next completion.
-- Do something similar with <S-Tab>.
map({ "i", "s" }, "<Tab>", function()
	if pumvisible() then
		feedkeys("<C-n>")
	elseif vim.snippet.active({ direction = 1 }) then
		vim.snippet.jump(1)
	else
		feedkeys("<Tab>")
	end
end, {})
map({ "i", "s" }, "<S-Tab>", function()
	if pumvisible() then
		feedkeys("<C-p>")
	elseif vim.snippet.active({ direction = -1 }) then
		vim.snippet.jump(-1)
	else
		feedkeys("<S-Tab>")
	end
end, {})
map("s", "<BS>", "<C-o>s", {})
