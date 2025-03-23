---wrap vim.keymap.set
---@param mode string|string[]
---@param lhs string
---@param rhs string|function
---@param opts string|vim.keymap.set.Opts
local function map(mode, lhs, rhs, opts)
	if type(opts) == "string" then
		vim.keymap.set(mode, lhs, rhs, { desc = opts })
	else
		vim.keymap.set(mode, lhs, rhs, opts)
	end
end
---wrap nvim_create_autocmd
---@param event any
---@param opts vim.api.keyset.create_autocmd
---@return integer
local autocmd = function(event, opts)
	return vim.api.nvim_create_autocmd(event, opts)
end
---wrap nvim_create_user_command
---@param name string
---@param command any
---@param opts vim.api.keyset.user_command
local user_command = function(name, command, opts)
	vim.api.nvim_create_user_command(name, command, opts)
end
---@param str string
local snake = function(str)
	return str:gsub("([a-z])([A-Z])", "%1_%2"):lower()
end
return { map = map, autocmd = autocmd, user_command = user_command, snake = snake }
