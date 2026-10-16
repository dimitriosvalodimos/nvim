return {
  {
    "folke/persistence.nvim",
    lazy = false,
    opts = { branch = true },
    init = function()
      vim.api.nvim_create_autocmd("VimEnter", {
        nested = true,
        callback = function()
          if vim.fn.argc() == 0 and not vim.g.started_with_stdin then
            require("persistence").load()
          end
        end,
      })
    end,
  },
}
