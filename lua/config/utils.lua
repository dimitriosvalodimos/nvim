local function map(mode, key, cmd, opts)
	vim.keymap.set(mode, key, cmd, opts)
end
return { map = map }
