local mode_colors = {
	n = "StatusLineModeNormal",
	i = "StatusLineModeInsert",
	v = "StatusLineModeVisual",
	[""] = "StatusLineModeVisual",
	V = "StatusLineModeVisual",
	c = "StatusLineModeCommand",
	R = "StatusLineModeReplace",
	t = "StatusLineModeTerminal",
}

local mode_names = {
	n = "N",
	i = "I",
	v = "V",
	[""] = "V-B",
	V = "V-L",
	c = "C",
	R = "R",
	t = "T",
}

local function get_mode()
	local mode = vim.api.nvim_get_mode().mode
	return "%#" .. (mode_colors[mode] or "StatusLineModeNormal") .. "#"
end

local function get_mode_name()
	local mode = vim.api.nvim_get_mode().mode
	return mode_names[mode] or mode
end

local function get_modified()
	if vim.bo.modified then
		return ""
	end
	return ""
end

vim.o.statusline = table.concat({
	"%{%v:lua.require'config.statusline'.get_mode()%}",
	" %{v:lua.require'config.statusline'.get_mode_name()} ",
	"%#StatusLinePath#",
	" %f ",
	"%#StatusLineModified#",
	"%{v:lua.require'config.statusline'.get_modified()}",
	"%#StatusLineFlags#",
	"%r%h%w",
	"%=",
	"%#StatusLineFileType#",
	" %{&filetype} ",
	"%#StatusLinePosition#",
	" %l:%c ",
})

return {
	get_mode = get_mode,
	get_mode_name = get_mode_name,
	get_modified = get_modified,
}
