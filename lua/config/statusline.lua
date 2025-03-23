local autocmd = require("config.utils").autocmd
local timer = nil
local _diagnostics = ""
local update = function()
	timer = nil
	local buf_diags = vim.diagnostic.count(0)
	local errors = " 󰅚 " .. (buf_diags[1] or 0)
	local warnings = " 󰀪 " .. (buf_diags[2] or 0)
	local hint = " 󰌶 " .. (buf_diags[3] or 0)
	local info = "  " .. (buf_diags[4] or 0)
	_diagnostics = errors .. warnings .. hint .. info
	vim.api.nvim__redraw({ statusline = true })
end
local diagnostics = function()
	return _diagnostics
end
autocmd("DiagnosticChanged", {
	callback = function()
		if timer then
			timer:close()
		end
		timer = vim.defer_fn(update, 5000)
	end,
})
vim.o.statusline = table.concat({
	"%#Statusline#",
	" %{v:lua.vim.fn.mode()}",
	" | %f ",
	"%M%r%h%w",
	"%=",
	" %{&filetype} ",
	" %l:%c | %L ",
	" %{v:lua.require('config.statusline').diagnostics()} ",
})
return { diagnostics = diagnostics }
