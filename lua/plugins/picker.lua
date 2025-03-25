local map = require("config.utils").map
return {
	"ibhagwan/fzf-lua",
	opts = {},
	config = function(_, opts)
		local fzf = require("fzf-lua")
		fzf.setup(opts)
		map("n", "<leader>ff", fzf.files, "find files")
		map("n", "<leader>fr", fzf.resume, "resume search")
		map("n", "<leader>fR", fzf.registers, "find register")
		map("n", "<leader>fb", fzf.buffers, "find buffer")
		map("n", "<leader>fg", fzf.live_grep, "find word")
		map("n", "<leader>fw", fzf.grep_cword, "find current word")
		map("n", "<leader>fh", fzf.helptags, "find helptag")
		map("n", "<leader>fk", fzf.keymaps, "find keymap")
		map("n", "<leader>/", fzf.lgrep_curbuf, "find in buffer")
	end,
}
