vim.o.statusline = table.concat({
	"%#Statusline#",
	" %{v:lua.vim.fn.mode()}",
	" | %f ",
	"%M%r%h%w",
	"%=",
	" %{&filetype} ",
	" %l:%c | %L ",
})
