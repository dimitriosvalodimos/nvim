local map = require("config.utils").map
return {
  "ibhagwan/fzf-lua",
  opts = {
    previewers = { syntax_limit_b = 1024 * 100, -- 100KB
    }
  },
  config = function(_, opts)
    local fzf = require("fzf-lua")
    fzf.setup(opts)
    map('n', "<leader>ff", fzf.files, { desc = "find file" })
    map('n', "<leader>fr", fzf.resume, { desc = "resume search" })
    map('n', "<leader>fR", fzf.registers, { desc = "find register" })
    map('n', "<leader>fb", fzf.buffers, { desc = "find buffer" })
    map('n', "<leader>fg", function() fzf.live_grep({ multiprocess = true }) end, { desc = "find word" })
    map('n', "<leader>fw", fzf.grep_cword, { desc = "find word under cursor" })
    map('n', "<leader>fh", fzf.helptags, { desc = "find helptag" })
    map('n', "<leader>fk", fzf.keymaps, { desc = "find keymap" })
    map('n', "<leader>/", fzf.lgrep_curbuf, { desc = "find in buffer" })
  end,
}
