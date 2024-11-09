local utils = require("config.utils")
utils.autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", {}),
	desc = "Highlight selection on yank",
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
	end,
})
utils.autocmd("LspProgress", {
	callback = function(ev)
		vim.notify(vim.lsp.status(), nil, {
			id = "lsp_progress",
			title = "LSP Progress",
			opts = function(notif)
				notif.icon = ev.data.params.value.kind == "end" and " " or "🔄"
			end,
		})
	end,
})
vim.api.nvim_create_user_command("Term", function()
	require("snacks").terminal.toggle()
end, {})
